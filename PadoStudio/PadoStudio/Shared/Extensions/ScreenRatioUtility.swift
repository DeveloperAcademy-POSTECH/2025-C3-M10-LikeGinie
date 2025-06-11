//
//  ScreenRatioUtility.swift
//  PadoStudio
//
//  Created by kim yijun on 6/4/25.
//

import SwiftUI
import UIKit

struct ScreenRatioUtility {
    // 화면 크기
    static var screenWidth: CGFloat { UIScreen.main.bounds.width }
    static var screenHeight: CGFloat { UIScreen.main.bounds.height }
    
    // 기준 아이폰 크기 (iPhone 14 기준)
    private static let baseWidth: CGFloat = 393
    private static let baseHeight: CGFloat = 852
    
    // 비율 계산
    static var widthRatio: CGFloat { screenWidth / baseWidth }
    static var heightRatio: CGFloat { screenHeight / baseHeight }
    static var ratio: CGFloat { min(widthRatio, heightRatio) }
    
    // 공통 크기 계산
    static var imageWidth: CGFloat { screenWidth * 0.8 }
    static var imageHeight: CGFloat { imageWidth * 4 / 3 }

    
    //프리뷰 사진 크기
    static var previewWidth: CGFloat { screenWidth * 0.6 }
    
    // 유틸리티 함수들
    static func scaledSize(_ size: CGFloat) -> CGFloat {
        return size * ratio
    }
    
    static func scaledWidth(_ width: CGFloat) -> CGFloat {
        return width * widthRatio
    }
    
    static func scaledHeight(_ height: CGFloat) -> CGFloat {
        return height * heightRatio
    }
    
    // 폰트 크기 스케일링
    static func scaledFont(size: CGFloat) -> Font {
        return .system(size: size * ratio)
    }
    
    // 패딩 스케일링
    static func scaledPadding(_ padding: CGFloat) -> CGFloat {
        return padding * ratio
    }
}

// 더 편한 사용을 위한 Extension
extension CGFloat {
    var scaled: CGFloat {
        return ScreenRatioUtility.scaledSize(self)
    }
}

extension Double {
    var scaled: CGFloat {
        return ScreenRatioUtility.scaledSize(CGFloat(self))
    }
}

extension Int {
    var scaled: CGFloat {
        return ScreenRatioUtility.scaledSize(CGFloat(self))
    }
}
