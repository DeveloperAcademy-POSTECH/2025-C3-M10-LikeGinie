//
//  SurferCharacterView.swift
//  PadoStudio
//
//  Created by 윤민경 on 6/3/25.
//

import SwiftUI

struct SurferCharacterView: View {
    @EnvironmentObject var viewModel: CharacterFrameViewModel

    @ViewBuilder
    private var previewImage: some View {
        Group {
            if let composedImage = viewModel.composedImage {
                Image(uiImage: composedImage)
                    .resizable()
            } else {
                Image(viewModel.selectedFrame.imgName)
                    .resizable()
            }
        }
        .scaledToFit()
        .frame(width: 300.scaled, height: 400.scaled)
        
    var body: some View {
        HStack{
            ForEach(0..<characterImages.count, id: \.self) { idx in
                Image(characterImages[idx])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 320)
            }
            viewModel.composeFramedPreview()
        }
        .frame(maxWidth: .infinity, alignment: .center) // 가운데 정렬
    }
}

#Preview {
    SurferCharacterView()
}
