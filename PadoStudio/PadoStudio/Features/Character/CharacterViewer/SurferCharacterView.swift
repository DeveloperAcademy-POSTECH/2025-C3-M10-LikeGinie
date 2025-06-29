//
//  SurferCharacterView.swift
//  PadoStudio
//
//  Created by 윤민경 on 6/3/25.
//

import SwiftUI

struct SurferCharacterView: View {
    @EnvironmentObject var viewModel: CharacterFrameViewModel
    let proxy: GeometryProxy
    let spacing: (spacing: CGFloat, spacingMore: CGFloat) = {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return (spacing: -30, spacingMore: -60)
        default:
            return (spacing: -10, spacingMore: -20)
        }
    }()

    private var characterWidth: CGFloat {
        let count = viewModel.characterImages.count
        return (count <= 3 ? 0.3 : 0.2) * ScreenRatioUtility.screenWidth

    }

    @ViewBuilder
    private var characterPreviewImages: some View {
        let spacing: CGFloat =
            viewModel.characterImages.count <= 3
            ? spacing.spacing : spacing.spacingMore

        HStack(spacing: spacing) {
            ForEach(viewModel.characterImages, id: \.self) { img in
                Image(uiImage: img)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: characterWidth,
                        height: characterWidth * 4 / 3
                    )
            }
        }
    }

    var body: some View {
        HStack {
            characterPreviewImages
        }
        .frame(maxWidth: .infinity, alignment: .center)  // 가운데 정렬
        .onAppear {
            Task {
                await viewModel.loadCharacterImages()
                viewModel.composeFramedPreview()
            }
        }
    }

}

#Preview {
    GeometryReader { proxy in
        SurferCharacterView(proxy: proxy)
            .environmentObject(CharacterFrameViewModel())
    }
}
