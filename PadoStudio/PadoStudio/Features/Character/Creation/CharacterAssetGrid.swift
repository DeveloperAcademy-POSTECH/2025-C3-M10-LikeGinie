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
            let part = viewModel.selectedPart
            let filteredAssets = viewModel.assets.filter { $0.part == part }
            let selectedAsset = viewModel.selectedAsset(for: part, index: currentIndex)

            LazyVGrid(
                columns: Array(
                    repeating: GridItem(.flexible(), spacing: 12), count: 3),
                spacing: 12
            ) {
                ForEach(filteredAssets) { asset in
                    let isSelected = selectedAsset == asset
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isSelected ? Color.primaryBlue : Color.clear, lineWidth: 3)
                            .background(Color.white)
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
        .onAppear {
            DispatchQueue.main.async {
                let part = viewModel.selectedPart
                let filteredAssets = viewModel.assets.filter { $0.part == part }
                if viewModel.selectedAsset(for: part, index: currentIndex) == nil,
                   let first = filteredAssets.first {
                    viewModel.select(asset: first, index: currentIndex)
                }
            }
        }
    }
}

#Preview {
    CharacterAssetGrid(viewModel: CharacterViewModel(), currentIndex: 0)
}
