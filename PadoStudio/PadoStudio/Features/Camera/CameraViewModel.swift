//
//  CameraViewModel.swift
//  PadoStudioSample
//
//  Created by kim yijun on 5/28/25.
//

import AVFoundation
import UIKit

class CameraViewModel: NSObject, ObservableObject {
    let session = AVCaptureSession()
    private let output = AVCapturePhotoOutput()
    private let sessionQueue = DispatchQueue(label: "cameraSessionQueue")
    
    @Published var currentPosition: AVCaptureDevice.Position = .front
    @Published var capturedImage: UIImage?

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
              session.canAddInput(input) else {
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
    
    func composeFramedImage(baseImage: UIImage, frameImageName: String = "프레임") -> UIImage? {
        print("이미지 합성 시작 - 프레임: \(frameImageName)")
        
        guard let frameImage = UIImage(named: frameImageName) else {
            print("프레임 이미지 로드 실패: \(frameImageName)")
            return nil
        }
        
        print("프레임 이미지 로드 성공")
        print("기본 이미지 크기: \(baseImage.size)")
        print("프레임 이미지 크기: \(frameImage.size)")

        let size = baseImage.size
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)

        baseImage.draw(in: CGRect(origin: .zero, size: size))
        frameImage.draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: 1.0)

        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if combinedImage != nil {
            print("이미지 합성 완료")
        } else {
            print("이미지 합성 실패 - UIGraphicsGetImageFromCurrentImageContext 반환값이 nil")
        }

        return combinedImage
    }

    
    func switchCamera() {
           sessionQueue.async {
               self.session.beginConfiguration()

               guard let currentInput = self.session.inputs.first as? AVCaptureDeviceInput else {
                   return
               }

               self.session.removeInput(currentInput)

               self.currentPosition = currentInput.device.position == .back ? .front : .back

               guard let newDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: self.currentPosition),
                     let newInput = try? AVCaptureDeviceInput(device: newDevice),
                     self.session.canAddInput(newInput) else {
                   print("전환 실패")
                   return
               }

               self.session.addInput(newInput)
               self.session.commitConfiguration()
           }
       }
}

extension CameraViewModel: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        guard let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data) else {
            print("사진 처리 실패")
            return
        }

        DispatchQueue.main.async {
            self.capturedImage = image  
        }

        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        print("사진 저장 완료")
    }
}
