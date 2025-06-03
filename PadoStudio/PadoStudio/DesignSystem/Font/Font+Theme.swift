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

    // MARK: - Named Styles
    static var largeTitleBold: Font {
        .dynamicCustom("EliceDigitalBaeum-Bd", size: 40)
    }

    static var largeTitleRegular: Font {
        .dynamicCustom("EliceDigitalBaeum", size: 40)
    }

    static var title1Bold: Font {
        .dynamicCustom("EliceDigitalBaeum-Bd", size: 32)
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
}


struct FontPreviewView: View {
    var body: some View {
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
                        .font(.title1Regular)
                    Text("Title2 Bold")
                        .font(.title2Bold)
                    Text("Title3 Bold")
                        .font(.title3Bold)
                }

                Group {
                    Text("Body Bold")
                        .font(.bodyBold)
                    Text("Caption1 Bold")
                        .font(.caption1Bold)
                    Text("Caption2 Bold")
                        .font(.caption2Bold)
                }

                Group {
                    Text("Elice Bold (Size: 18)")
                        .font(.eliceBold(size: 18))
                    Text("Styled Regular (Size: 20)")
                        .font(.styledRegular(size: 20))
                    Text("Sinchon Rhapsody (Size: 32)")
                        .font(.largeSinchonTitle(size: 32))
                }
            }
            .padding()
        }
        .navigationTitle("Font Preview")
    }
}

#Preview("폰트 미리보기") {
    NavigationView {
        FontPreviewView()
    }
}
