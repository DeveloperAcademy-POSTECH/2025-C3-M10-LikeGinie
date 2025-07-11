//
//  CameraViewModel.swift
//  PadoStudioSample
//
//  Created by kim yijun on 5/28/25.
//

import AVFoundation
import Dependencies
import UIKit

class CameraViewModel: NSObject, ObservableObject {
    let session = AVCaptureSession()
    private let output = AVCapturePhotoOutput()
    private let sessionQueue = DispatchQueue(label: "cameraSessionQueue")

    @Published var currentPosition: AVCaptureDevice.Position = .front
    @Published var capturedImage: UIImage?
    @Published var selectedCharacters: [String] = []
    @Published var characterImages: [UIImage] = []
    @Published var isSessionReady = false
    @Published var cameraError: CameraError?
    @Published var isPresentingCamera = false
    @Dependency(\.getCharactersUseCase) var getCharactersUseCase

    private var isConfigured = false
    
    override init() {
        super.init()
    }

    func configure() {
        guard !isConfigured else { return }
        isConfigured = true
        
        sessionQueue.async {
            self.checkCameraPermission()
        }
    }

    private func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            // The user has previously granted access to the camera.
            self.setupSession()
            self.session.startRunning()
        case .notDetermined:
            // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.setupSession()
                    self.session.startRunning()
                } else {
                    DispatchQueue.main.async {
                        self.cameraError = .permissionDenied
                    }
                }
            }
        case .denied, .restricted:
            // The user has previously denied access.
            DispatchQueue.main.async {
                self.cameraError = .permissionDenied
            }
        @unknown default:
            fatalError("Unknown camera authorization status")
        }
    }
    
    private func setupSession() {
        session.beginConfiguration()
        session.sessionPreset = .photo

        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: currentPosition),
              let input = try? AVCaptureDeviceInput(device: device),
              session.canAddInput(input)
        else {
            print(CameraError.noInput.errorDescription ?? "error")
            DispatchQueue.main.async {
                self.cameraError = .noInput
            }
            session.commitConfiguration()
            return
        }

        session.addInput(input)

        guard session.canAddOutput(output) else {
            print(CameraError.cannotAddOutput.errorDescription ?? "error")
            DispatchQueue.main.async {
                self.cameraError = .cannotAddOutput
            }
            session.commitConfiguration()
            return
        }

        session.addOutput(output)
        session.commitConfiguration()
        DispatchQueue.main.async {
            self.isSessionReady = true
        }
    }

    func takePhoto() {
        guard session.isRunning, output.connection(with: .video) != nil else {
            print("세션이 실행 중이 아니거나 비디오 연결이 없습니다.")
            return
        }

        let settings = AVCapturePhotoSettings()
        settings.flashMode = .auto
        output.capturePhoto(with: settings, delegate: self)
    }

    func switchCamera() {
        sessionQueue.async {
            self.session.beginConfiguration()

            guard
                let currentInput = self.session.inputs.first
                    as? AVCaptureDeviceInput
            else {
                return
            }

            self.session.removeInput(currentInput)

            let newPosition: AVCaptureDevice.Position =
                currentInput.device.position == .back ? .front : .back

            guard
                let newDevice = AVCaptureDevice.default(
                    .builtInWideAngleCamera, for: .video, position: newPosition),
                let newInput = try? AVCaptureDeviceInput(device: newDevice),
                self.session.canAddInput(newInput)
            else {
                print(CameraError.switchFailed.errorDescription ?? "error")
                DispatchQueue.main.async {
                    self.cameraError = .switchFailed
                }
                return
            }

            self.session.addInput(newInput)
            self.session.commitConfiguration()

            // UI 업데이트를 메인 스레드에서 수행
            DispatchQueue.main.async {
                self.currentPosition = newPosition
            }
        }
    }

    func fetchCompletedCharacters() async {
        do {
            let characters = try await getCharactersUseCase()

            // imagePath -> UIImage 로 변환
            let images: [UIImage] = characters.compactMap { character in
                UIImage(contentsOfFile: character.imagePath)
            }

            await MainActor.run {
                self.characterImages = images
            }
        } catch {
            print("캐릭터 불러오기 실패: \(error)")
        }
    }
    
    @MainActor
    func stopSession() {
        if session.isRunning { session.stopRunning() }
        isSessionReady = false
        isConfigured = false
    }
}

extension CameraViewModel: AVCapturePhotoCaptureDelegate {
    func photoOutput(
        _ output: AVCapturePhotoOutput,
        didFinishProcessingPhoto photo: AVCapturePhoto,
        error: Error?
    ) {
        guard let data = photo.fileDataRepresentation(),
            let image = UIImage(data: data)
        else {
            print("사진 처리 실패")
            return
        }

        DispatchQueue.main.async {
            // 전면 카메라일 때 좌우반전 처리
            if self.currentPosition == .front {
                self.capturedImage = self.flipImageHorizontally(image: image)
            } else {
                self.capturedImage = image
            }
        }

        // 저장할 때도 좌우반전 처리된 이미지 저장
        let imageToSave =
            currentPosition == .front
            ? flipImageHorizontally(image: image) : image
        UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
        print("사진 저장 완료")
    }

    // 이미지 좌우반전 함수
    private func flipImageHorizontally(image: UIImage) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        let context = UIGraphicsGetCurrentContext()!

        context.translateBy(x: image.size.width, y: 0)
        context.scaleBy(x: -1.0, y: 1.0)

        image.draw(at: CGPoint.zero)

        let flippedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return flippedImage ?? image
    }
}
