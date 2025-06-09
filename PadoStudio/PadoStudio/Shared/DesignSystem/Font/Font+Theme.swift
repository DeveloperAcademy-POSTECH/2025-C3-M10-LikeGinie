//
//  AppFont.swift
//  PadoStudio
//
//  Created by eunsong on 6/1/25.
//
import SwiftUI
import UIKit

extension Font {
    // 시스템 접근성 설정을 반영한 커스텀 폰트 생성기
    static func dynamicCustom(_ name: String, size: CGFloat) -> Font {
        guard let uiFont = UIFont(name: name, size: size) else {
            return .system(size: size) // fallback
        }
        let scaled = UIFontMetrics.default.scaledFont(for: uiFont)
        return Font(scaled)
    }

    static func responsiveDynamicCustom(_ name: String, baseSize: CGFloat, proxy: GeometryProxy) -> Font {
        let width = proxy.size.width
        let ratio = width / 375.0 // 기준 기기 너비 (iPhone 11)
        let adjustedSize = baseSize * ratio

        guard let uiFont = UIFont(name: name, size: adjustedSize) else {
            return .system(size: adjustedSize)
        }

        let scaled = UIFontMetrics.default.scaledFont(for: uiFont)
        return Font(scaled)
    }

    // MARK: - Named Styles (폰트 설정 고려)
    static var largeTitleBold: Font {
        .dynamicCustom("EliceDigitalBaeum-Bd", size: 40)
    }

    static var largeTitleRegular: Font {
        .dynamicCustom("EliceDigitalBaeum", size: 40)
    }

    static var title1Bold: Font {
        .dynamicCustom("EliceDigitalBaeum-Bd", size: 32.scaled)
    }

    static var title1Regular: Font {
        .dynamicCustom("EliceDigitalBaeum", size: 32)
    }

    static var title2Bold: Font {
        .dynamicCustom("EliceDigitalBaeum-Bd", size: 24)
    }

    static var title3Bold: Font {
        .dynamicCustom("EliceDigitalBaeum-Bd", size: 20)
    }

    static var bodyBold: Font {
        .dynamicCustom("EliceDigitalBaeum-Bd", size: 17)
    }

    static var caption1Bold: Font {
        .dynamicCustom("EliceDigitalBaeum-Bd", size: 12)
    }

    static var caption2Bold: Font {
        .dynamicCustom("EliceDigitalBaeum-Bd", size: 11)
    }

    static func eliceBold(size: CGFloat) -> Font {
        .dynamicCustom("EliceDigitalBaeum-Bd", size: size)
    }

    static func styledRegular(size: CGFloat) -> Font {
        .dynamicCustom("EliceDigitalBaeum", size: size)
    }

    static func largeSinchonTitle(size: CGFloat) -> Font {
        .dynamicCustom("SinchonRhapsodyTTF-ExtraBold", size: size)
    }
    
    
    // MARK: 기기 너비 고려된 폰트 사이즈 (기종 사이즈별 고려 가능)
    static func title1RegularResponsive(_ proxy: GeometryProxy) -> Font {
        .responsiveDynamicCustom("EliceDigitalBaeum", baseSize: 32, proxy: proxy)
    }

    static func title2BoldResponsive(_ proxy: GeometryProxy) -> Font {
        .responsiveDynamicCustom("EliceDigitalBaeum-Bd", baseSize: 24, proxy: proxy)
    }
    
    static func title3BoldResponsive(size: CGFloat, proxy: GeometryProxy) -> Font {
        .responsiveDynamicCustom("EliceDigitalBaeum-Bd", baseSize: size, proxy: proxy)
    }

    static func title3RegularResponsive(size: CGFloat, proxy: GeometryProxy) -> Font {
        .responsiveDynamicCustom("EliceDigitalBaeum", baseSize: size, proxy: proxy)
    }

    static func bodyBoldResponsive(_ proxy: GeometryProxy) -> Font {
        .responsiveDynamicCustom("EliceDigitalBaeum-Bd", baseSize: 17, proxy: proxy)
    }

    static func caption1BoldResponsive(_ proxy: GeometryProxy) -> Font {
        .responsiveDynamicCustom("EliceDigitalBaeum-Bd", baseSize: 12, proxy: proxy)
    }

    static func caption2BoldResponsive(_ proxy: GeometryProxy) -> Font {
        .responsiveDynamicCustom("EliceDigitalBaeum-Bd", baseSize: 11, proxy: proxy)
    }

    static func eliceBoldResponsive(size: CGFloat, proxy: GeometryProxy) -> Font {
        .responsiveDynamicCustom("EliceDigitalBaeum-Bd", baseSize: size, proxy: proxy)
    }

    static func styledRegularResponsive(size: CGFloat, proxy: GeometryProxy) -> Font {
        .responsiveDynamicCustom("EliceDigitalBaeum", baseSize: size, proxy: proxy)
    }

    static func largeSinchonTitleResponsive(size: CGFloat, proxy: GeometryProxy) -> Font {
        .responsiveDynamicCustom("SinchonRhapsodyTTF-ExtraBold", baseSize: size, proxy: proxy)
    }
}


struct FontPreviewView: View {
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Group {
                        Text("LargeTitle Bold")
                            .font(.largeTitleBold)
                        Text("LargeTitle Regular")
                            .font(.largeTitleRegular)
                        Text("Title1 Bold")
                            .font(.title1Bold)
                        Text("Title1 Regular")
                            .font(.title1RegularResponsive(proxy))
                        Text("Title2 Bold")
                            .font(.title2BoldResponsive(proxy))
                        Text("Title3 Bold")
                            .font(.title3RegularResponsive(size: 20, proxy: proxy))
                    }

                    Group {
                        Text("Body Bold")
                            .font(.bodyBoldResponsive(proxy))
                        Text("Caption1 Bold")
                            .font(.caption1BoldResponsive(proxy))
                        Text("Caption2 Bold")
                            .font(.caption2BoldResponsive(proxy))
                    }

                    Group {
                        Text("Elice Bold (Size: 18)")
                            .font(.eliceBoldResponsive(size: 18, proxy: proxy))
                        Text("Styled Regular (Size: 20)")
                            .font(.styledRegularResponsive(size: 20, proxy: proxy))
                        Text("Sinchon Rhapsody (Size: 32)")
                            .font(.largeSinchonTitleResponsive(size: 32, proxy: proxy))
                    }
                }
                .padding()
            }
            .navigationTitle("Font Preview")
        }
    }
}

#Preview("폰트 미리보기") {
    NavigationView {
        FontPreviewView()
    }
}
