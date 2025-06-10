//
//  FramePreviewUtil.swift
//  PadoStudio
//
//  Created by eunsong on 6/10/25.
//
import UIKit
import Foundation

struct FramePreviewUtil {
    static func composeFramedPreviewWithTransparentBase(size: CGSize, frameImageName: String, characterImages: [UIImage]) -> UIImage? {
        let baseImage = createTransparentBaseImage(size: size)
        return ImageComposer.composeFramedImageWithCharacters(
            baseImage: baseImage,
            frameImageName: frameImageName,
            characterImages: characterImages
        )
    }

    static func createTransparentBaseImage(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }

        let rect = CGRect(origin: .zero, size: size)
        UIColor.clear.setFill()
        UIRectFill(rect)

        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
}
