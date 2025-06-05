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
    @Published var selectedCharacters: [String] = []

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
    
    func composeFramedImageWithCharacters(baseImage: UIImage, frameImageName: String = "Frame1") -> UIImage? {
        print("캐릭터 포함 이미지 합성 시작 - 프레임: \(frameImageName)")
        
        guard let frameImage = UIImage(named: frameImageName) else {
            print("프레임 이미지 로드 실패: \(frameImageName)")
            return nil
        }
        
        let size = baseImage.size
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
       
        baseImage.draw(in: CGRect(origin: .zero, size: size))
        
       
        frameImage.draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: 1.0)
        
        
        let scaleX = size.width / ScreenRatioUtility.imageWidth
        let scaleY = size.height / ScreenRatioUtility.imageHeight
        
        
        let maxSize = min(150 * scaleX, (ScreenRatioUtility.imageWidth * scaleX) / CGFloat(selectedCharacters.count))
        let characterWidth = maxSize
        let characterHeight = maxSize
        
        
        let spacing: CGFloat = -10 * scaleX
        
        let totalWidth = CGFloat(selectedCharacters.count) * characterWidth + CGFloat(selectedCharacters.count - 1) * spacing
        let startX = (size.width - totalWidth) / 2
        
        
        let bottomMargin = 50 * scaleY
        let yPosition = size.height - characterHeight - bottomMargin
        
        for (index, characterName) in selectedCharacters.enumerated() {
            if let characterImage = UIImage(named: characterName) {
                let xPosition = startX + CGFloat(index) * (characterWidth + spacing)
                let characterRect = CGRect(x: xPosition, y: yPosition, width: characterWidth, height: characterHeight)
                characterImage.draw(in: characterRect)
                print("캐릭터 \(characterName) 그리기 완료 - 위치: \(characterRect), 크기: \(characterWidth)x\(characterHeight)")
            } else {
                print("캐릭터 이미지 로드 실패: \(characterName)")
            }
        }
        
        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if combinedImage != nil {
            print("캐릭터 포함 이미지 합성 완료")
        } else {
            print("캐릭터 포함 이미지 합성 실패")
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
