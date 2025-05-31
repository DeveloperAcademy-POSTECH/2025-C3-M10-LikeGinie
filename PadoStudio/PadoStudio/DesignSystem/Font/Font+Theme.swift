//
//  AppFont.swift
//  PadoStudio
//
//  Created by eunsong on 6/1/25.
//
import SwiftUI

enum FontTheme {
    static func largeTitleBold() -> Font {
        .custom("EliceDigitalBaeum-Bold", size: 40)
    }

    static func largeTitleRegular() -> Font {
        .custom("EliceDigitalBaeum-Regular", size: 40)
    }

    static func title1Bold() -> Font {
        .custom("EliceDigitalBaeum-Bold", size: 32)
    }

    static func title1Regular() -> Font {
        .custom("EliceDigitalBaeum-Regular", size: 32)
    }

    static func title2Bold() -> Font {
        .custom("EliceDigitalBaeum-Bold", size: 24)
    }

    static func title3Bold() -> Font {
        .custom("EliceDigitalBaeum-Bold", size: 20)
    }

    static func bodyBold() -> Font {
        .custom("EliceDigitalBaeum-Bold", size: 17)
    }

    static func caption1Bold() -> Font {
        .custom("EliceDigitalBaeum-Bold", size: 12)
    }

    static func caption2Bold() -> Font {
        .custom("EliceDigitalBaeum-Bold", size: 11)
    }

    static func eliceBold(size: CGFloat) -> Font {
        .custom("EliceDigitalBaeum-Bold", size: size)
    }

    static func styledRegular(size: CGFloat) -> Font {
        .custom("StyledFont-Regular", size: size)
    }
}


struct FontPreviewView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("LargeTitle Bold")
                .font(FontTheme.largeTitleBold())

            Text("Title1 Regular")
                .font(FontTheme.title1Regular())

            Text("Body Bold")
                .font(FontTheme.bodyBold())

            Text("Styled Custom")
                .font(FontTheme.styledRegular(size: 20))
        }
        .padding()
    }
}

#Preview("폰트 미리보기") {
    FontPreviewView()
}
