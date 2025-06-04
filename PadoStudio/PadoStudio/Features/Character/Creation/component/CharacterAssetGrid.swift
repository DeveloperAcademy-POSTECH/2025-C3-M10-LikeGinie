//
//  CharacterAssetGrid.swift
//  PadoStudio
//
//  Created by eunsong on 6/1/25.
//
import SwiftUI

struct CharacterAssetGrid: View {
    let proxy: GeometryProxy
    @ObservedObject var viewModel: CharacterViewModel
    let currentIndex: Int

    var body: some View {
        let spacing: CGFloat = 16.scaled
        let columnCount = 4
        let totalSpacing = spacing * CGFloat(columnCount - 1)
        let totalHorizontalPadding = proxy.size.width * 0.06 * 2
        let itemSide = (proxy.size.width - totalSpacing - totalHorizontalPadding) / CGFloat(columnCount)
        let columns = Array(repeating: GridItem(.flexible(), spacing: spacing), count: columnCount)
        ScrollView {
            let part = viewModel.selectedPart
            let filteredAssets = viewModel.assets.filter { $0.part == part }
            let selectedAsset = viewModel.selectedAsset(
                for: part, index: currentIndex)

            LazyVGrid(
                columns: columns,
                spacing: spacing
            ) {
                ForEach(filteredAssets) { asset in
                    let isSelected = selectedAsset == asset
                    CharacterAssetItemView(
                        asset: asset, isSelected: isSelected, size: itemSide
                    )
                    .onTapGesture {
                        viewModel.select(asset: asset, index: currentIndex)
                    }
                }
            }
            .padding(.horizontal, proxy.size.width * 0.06)
            .padding(.vertical, proxy.size.width * 0.06)
        }
        .onAppear {
            DispatchQueue.main.async {
                let part = viewModel.selectedPart
                let filteredAssets = viewModel.assets.filter { $0.part == part }
                if viewModel.selectedAsset(for: part, index: currentIndex)
                    == nil,
                    let first = filteredAssets.first
                {
                    viewModel.select(asset: first, index: currentIndex)
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.gray02)
        )
    }
}

#Preview {
    GeometryReader { proxy in
        CharacterAssetGrid(
            proxy: proxy, viewModel: CharacterViewModel(), currentIndex: 0).background(Color.cyan)
    }
}
