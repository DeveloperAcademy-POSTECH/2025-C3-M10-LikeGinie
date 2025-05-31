//
//  CharacterAssetGrid.swift
//  PadoStudio
//
//  Created by eunsong on 6/1/25.
//
import SwiftUI

struct CharacterAssetGrid: View {
    @ObservedObject var viewModel: CharacterViewModel
    let currentIndex: Int

    var body: some View {
        ScrollView {
            let filteredAssets = viewModel.assets.filter {
                $0.part == viewModel.selectedPart
            }
            let selectedAsset = viewModel.selectedAsset(
                for: viewModel.selectedPart, index: currentIndex)

            LazyVGrid(
                columns: Array(
                    repeating: GridItem(.flexible(), spacing: 12), count: 3),
                spacing: 12
            ) {
                ForEach(filteredAssets) { asset in
                    let isSelected = selectedAsset == asset
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                isSelected
                                    ? Color
                                        .accentColor
                                    : Color.gray.opacity(0.1)
                            )
                            .frame(height: 72)

                        Image(asset.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 60)
                    }
                    .onTapGesture {
                        viewModel.select(asset: asset, index: currentIndex)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    CharacterAssetGrid(viewModel: CharacterViewModel(), currentIndex: 0)
}
