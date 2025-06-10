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

    @Dependency(\.getCharactersUseCase) var getCharactersUseCase

    override init() {
        super.init()
    }

    func configure() {
        sessionQueue.async {
            self.setupSession()
            self.session.startRunning()
        }
    }

    private func setupSession() {
        session.beginConfiguration()
        session.sessionPreset = .photo

        guard let device = AVCaptureDevice.default(for: .video),
            let input = try? AVCaptureDeviceInput(device: device),
            session.canAddInput(input)
        else {
            print("카메라 입력 오류")
            session.commitConfiguration()
            return
        }

        session.addInput(input)

        guard session.canAddOutput(output) else {
            print("출력 추가 실패")
            session.commitConfiguration()
            return
        }

        session.addOutput(output)
        session.commitConfiguration()
    }

    func takePhoto() {
        guard session.isRunning else {
            print("세션 실행 안됨")
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
                print("전환 실패")
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
