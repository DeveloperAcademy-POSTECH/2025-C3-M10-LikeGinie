//
//  ImageComposer.swift
//  PadoStudio
//
//  Created by kim yijun on 6/5/25.
//


import UIKit
import Foundation

// UIImage extension for fixing orientation
extension UIImage {
    func fixOrientation() -> UIImage {
        if imageOrientation == .up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
}

class ImageComposer {
    
    static func composeFramedImageWithCharacters(
        baseImage: UIImage,
        frameImageName: String = "frame_sea",
        characterImages: [UIImage]
    ) -> UIImage? {
        print("캐릭터 포함 이미지 합성 시작 - 프레임: \(frameImageName)")
        print("완성된 캐릭터 수: \(characterImages.count)")
        
        guard let frameImage = UIImage(named: frameImageName) else {
            print("프레임 이미지 로드 실패: \(frameImageName)")
            return nil
        }
        
        // 화면에서 보이는 프레임 비율(4:3)로 크기 설정
        let targetWidth = ScreenRatioUtility.imageWidth * UIScreen.main.scale
        let targetHeight = ScreenRatioUtility.imageHeight * UIScreen.main.scale
        let size = CGSize(width: targetWidth, height: targetHeight)
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        
        // 베이스 이미지와 프레임 그리기
        drawBaseAndFrame(baseImage: baseImage, frameImage: frameImage, size: size)
        
        // 완성된 캐릭터 이미지들 그리기
        drawCharacterImages(characterImages: characterImages, size: size)
        
        // 날짜 텍스트 그리기
        drawDateText(on: size)
        
        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
        logCompletionStatus(combinedImage)
        
        return combinedImage
    }
    
    // 하위 호환성을 위한 기존 함수 유지 - Deprecated
    @available(*, deprecated, message: "Use composeFramedImageWithCharacters(baseImage:frameImageName:characterImages:) instead.")
    static func composeFramedImageWithCharacters(
        baseImage: UIImage,
        frameImageName: String = "frame_sea",
        selectedCharacters: [String]
    ) -> UIImage? {
        // 기존 방식은 더 이상 사용하지 않음
        return nil
    }
}


private extension ImageComposer {
    
    static func drawBaseAndFrame(baseImage: UIImage, frameImage: UIImage, size: CGSize) {
        // 베이스 이미지를 4:3 비율에 맞게 크롭하여 그리기
        let croppedBaseImage = cropImageToAspectRatio(baseImage, targetSize: size)
        croppedBaseImage.draw(in: CGRect(origin: .zero, size: size))
        
        // 프레임 이미지 그리기 - 전체 크기에 맞게
        frameImage.draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: 1.0)
    }
    
    static func cropImageToAspectRatio(_ image: UIImage, targetSize: CGSize) -> UIImage {
        let targetAspectRatio = targetSize.width / targetSize.height
        let imageAspectRatio = image.size.width / image.size.height
        
        // 이미지 방향 고려
        let orientedImage = image.fixOrientation()
        
        var cropRect: CGRect
        
        if imageAspectRatio > targetAspectRatio {
            // 이미지가 더 넓은 경우 - 좌우를 자름
            let newWidth = orientedImage.size.height * targetAspectRatio
            let xOffset = (orientedImage.size.width - newWidth) / 2
            cropRect = CGRect(x: xOffset, y: 0, width: newWidth, height: orientedImage.size.height)
        } else {
            // 이미지가 더 높은 경우 - 상하를 자름
            let newHeight = orientedImage.size.width / targetAspectRatio
            let yOffset = (orientedImage.size.height - newHeight) / 2
            cropRect = CGRect(x: 0, y: yOffset, width: orientedImage.size.width, height: newHeight)
        }
        
        guard let cgImage = orientedImage.cgImage?.cropping(to: cropRect) else {
            return orientedImage
        }
        
        return UIImage(cgImage: cgImage, scale: orientedImage.scale, orientation: .up)
    }
    
    static func drawCharacterImages(characterImages: [UIImage], size: CGSize) {
        let layout = calculateCharacterLayout(for: size, characterCount: characterImages.count)

        for (index, image) in characterImages.enumerated() {
            let rect = layout.rectFor(index: index)

            // 이미지 비율 맞추기
            let aspectRatio = image.size.width / image.size.height
            var drawRect = rect

            if aspectRatio > 1.0 {
                let newHeight = rect.width / aspectRatio
                drawRect = CGRect(
                    x: rect.minX,
                    y: rect.minY + (rect.height - newHeight) / 2,
                    width: rect.width,
                    height: newHeight
                )
            } else {
                let newWidth = rect.height * aspectRatio
                drawRect = CGRect(
                    x: rect.minX + (rect.width - newWidth) / 2,
                    y: rect.minY,
                    width: newWidth,
                    height: rect.height
                )
            }

            image.draw(in: drawRect)
            print("캐릭터 \(index) 이미지 그리기 완료 - 위치: \(drawRect)")
        }
    }
    
    static func calculateCharacterLayout(for size: CGSize, characterCount: Int) -> CharacterLayout {
        // CameraView와 동일한 방식으로 계산
        let imageScale = size.width / ScreenRatioUtility.imageWidth
        
        // CameraView와 동일한 캐릭터 크기 계산
        let maxSize = min(150.scaled * imageScale, (size.width) / CGFloat(max(characterCount, 1)))
        let spacing: CGFloat = -10.scaled * imageScale
        
        // CameraView와 동일한 bottomPadding 사용
        let bottomPadding = 50.scaled * imageScale
        
        // 캐릭터 위치를 더 아래로
        let yPosition = size.height - maxSize - bottomPadding
        
        // 전체 너비 계산 (CameraView와 동일)
        let totalWidth = CGFloat(characterCount) * maxSize + CGFloat(max(characterCount - 1, 0)) * spacing
        let startX = (size.width - totalWidth) / 2
        
        return CharacterLayout(
            characterSize: maxSize,
            spacing: spacing,
            startX: startX,
            yPosition: yPosition
        )
    }
    
    static func logCompletionStatus(_ image: UIImage?) {
        if image != nil {
            print("캐릭터 포함 이미지 합성 완료")
        } else {
            print("캐릭터 포함 이미지 합성 실패")
        }
    }
    
    static func drawDateText(on size: CGSize) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        let dateString = dateFormatter.string(from: Date())
        
        
        let fontSize: CGFloat = 20 * (size.width / ScreenRatioUtility.imageWidth)
        
        
        let font = UIFont(name: "EliceDigitalBaeum-Bd", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .semibold)
        
       
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white,
            .strokeColor: UIColor.black,
            .strokeWidth: -2.0
        ]
        
        let attributedString = NSAttributedString(string: dateString, attributes: attributes)
        let textSize = attributedString.size()
        
        // 우측 상단 위치 (여백 20pt)
        let margin: CGFloat = 20 * (size.width / ScreenRatioUtility.imageWidth)
        let textRect = CGRect(
            x: size.width - textSize.width - margin,
            y: margin,
            width: textSize.width,
            height: textSize.height
        )
        
        attributedString.draw(in: textRect)
    }
}


private struct CharacterLayout {
    let characterSize: CGFloat
    let spacing: CGFloat
    let startX: CGFloat
    let yPosition: CGFloat
    
    func rectFor(index: Int) -> CGRect {
        let xPosition = startX + CGFloat(index) * (characterSize + spacing)
        return CGRect(x: xPosition, y: yPosition, width: characterSize, height: characterSize)
    }
}
