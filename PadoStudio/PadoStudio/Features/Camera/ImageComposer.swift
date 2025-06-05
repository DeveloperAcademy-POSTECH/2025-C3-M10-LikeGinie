//
//  ImageComposer.swift
//  PadoStudio
//
//  Created by kim yijun on 6/5/25.
//


import UIKit
import Foundation

class ImageComposer {
    
    static func composeFramedImageWithCharacters(
        baseImage: UIImage,
        frameImageName: String = "Frame1",
        selectedCharacters: [String]
    ) -> UIImage? {
        print("캐릭터 포함 이미지 합성 시작 - 프레임: \(frameImageName)")
        
        guard let frameImage = UIImage(named: frameImageName) else {
            print("프레임 이미지 로드 실패: \(frameImageName)")
            return nil
        }
        
        let size = baseImage.size
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        
       
        drawBaseAndFrame(baseImage: baseImage, frameImage: frameImage, size: size)
        
        
        drawCharacters(selectedCharacters: selectedCharacters, size: size)
        
        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
        logCompletionStatus(combinedImage)
        
        return combinedImage
    }
}


private extension ImageComposer {
    
    static func drawBaseAndFrame(baseImage: UIImage, frameImage: UIImage, size: CGSize) {
        baseImage.draw(in: CGRect(origin: .zero, size: size))
        frameImage.draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: 1.0)
    }
    
    static func drawCharacters(selectedCharacters: [String], size: CGSize) {
        let characterLayout = calculateCharacterLayout(for: size, characterCount: selectedCharacters.count)
        
        for (index, characterName) in selectedCharacters.enumerated() {
            guard let characterImage = UIImage(named: characterName) else {
                print("캐릭터 이미지 로드 실패: \(characterName)")
                continue
            }
            
            let characterRect = characterLayout.rectFor(index: index)
            characterImage.draw(in: characterRect)
            print("캐릭터 \(characterName) 그리기 완료 - 위치: \(characterRect), 크기: \(characterLayout.characterSize)x\(characterLayout.characterSize)")
        }
    }
    
    static func calculateCharacterLayout(for size: CGSize, characterCount: Int) -> CharacterLayout {
        let scaleX = size.width / ScreenRatioUtility.imageWidth
        let scaleY = size.height / ScreenRatioUtility.imageHeight
        
        let maxSize = min(150 * scaleX, (ScreenRatioUtility.imageWidth * scaleX) / CGFloat(characterCount))
        let spacing: CGFloat = -10 * scaleX
        let bottomMargin = 50 * scaleY
        
        let totalWidth = CGFloat(characterCount) * maxSize + CGFloat(characterCount - 1) * spacing
        let startX = (size.width - totalWidth) / 2
        let yPosition = size.height - maxSize - bottomMargin
        
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

