//
//  CharacterFrameButtonList.swift
//  PadoStudio
//
//  Created by Oh Seojin on 6/9/25.
//

import SwiftUI

struct CharacterFrameButtonList: View {
    let selectedFrame: FrameType
    let onFrameSelected: (FrameType) -> Void
    let proxy: GeometryProxy
    let buttonSize: (width: CGFloat, pointWidth: CGFloat, spacing: CGFloat) = {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return (width: 100, pointWidth: 140, spacing: 32)
        default:
            return (width: 60, pointWidth: 72, spacing: 20)
        }
    }()

    var body: some View {
        HStack(spacing: buttonSize.spacing) {
            ForEach(FrameType.allCases, id: \.self) { f in
                Button {
                    onFrameSelected(f)
                } label: {
                    VStack {
                        Image(f.btnImgName)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(100)
                            .clipShape(Circle())
                            .frame(
                                width: selectedFrame == f
                                    ? buttonSize.pointWidth : buttonSize.width
                            )

                            .overlay(
                                Circle().stroke(
                                    selectedFrame == f
                                        ? Color.primaryGreen : Color.gray05,
                                    lineWidth: selectedFrame == f ? 6 : 1
                                )
                            )
                    }
                }
            }
        }
        .padding(8)
        .padding(.top, 24)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    GeometryReader { proxy in
        CharacterFrameButtonList(
            selectedFrame: .sea,
            onFrameSelected: { _ in },
            proxy: proxy
        )
    }
}
