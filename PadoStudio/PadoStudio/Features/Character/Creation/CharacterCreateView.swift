//
//  CharacterCreateView.swift
//  PadoStudio
//
//  Created by eunsong on 5/31/25.
//
import SwiftUI

struct CharacterCreateView: View {
    let number: Int
    @StateObject var viewModel = CharacterViewModel()
    @State private var currentIndex: Int = 0

    var body: some View {
        VStack {
            CharacterPreviewPager(number: number, currentIndex: $currentIndex, viewModel: viewModel)

            CharacterPartSelector(viewModel: viewModel)

            CharacterAssetGrid(viewModel: viewModel, currentIndex: currentIndex)
        }
        .padding()
    }
}


// Helper view to break down ZStack ForEach content for compiler
private struct CharacterPartPreview: View {
    let part: CharacterPartType
    let previewName: String?

    var body: some View {
        // Assign previewName to a local variable for clarity (already passed as prop)
        let name = previewName
        if let name = name {
            Image(name)
                .resizable()
                .scaledToFit()
        }
    }
}

private struct CharacterPreviewPager: View {
    let number: Int
    @Binding var currentIndex: Int
    @ObservedObject var viewModel: CharacterViewModel

    var body: some View {
        HStack {
            Button(action: {
                if currentIndex > 0 {
                    currentIndex -= 1
                }
            }) {
                Image(systemName: "chevron.left")
                    .padding()
            }

            let previews = CharacterPartType.allCases.map { part in
                (part, viewModel.getPreview(for: part, index: currentIndex))
            }

            ZStack {
                ForEach(previews, id: \.0) { part, name in
                    CharacterPartPreview(part: part, previewName: name)
                }
            }
            .frame(maxWidth: .infinity)

            Button(action: {
                if currentIndex < number - 1 {
                    currentIndex += 1
                }
            }) {
                Image(systemName: "chevron.right")
                    .padding()
            }
        }
    }
}

private struct CharacterPartSelector: View {
    @ObservedObject var viewModel: CharacterViewModel

    var body: some View {
        let allParts = CharacterPartType.allCases

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(allParts, id: \.self) { part in
                    CharacterPartItem(
                        part: part,
                        isSelected: viewModel.selectedPart == part
                    )
                    .onTapGesture {
                        viewModel.selectedPart = part
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

private struct CharacterPartItem: View {
    let part: CharacterPartType
    let isSelected: Bool

    var body: some View {
        Text(part.label)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(isSelected ? Color("PrimaryBlue") : Color.gray.opacity(0.2))
            .cornerRadius(12)
            .foregroundColor(isSelected ? .white : .black)
    }
}

private struct CharacterAssetGrid: View {
    @ObservedObject var viewModel: CharacterViewModel
    let currentIndex: Int

    var body: some View {
        ScrollView {
            let filteredAssets = viewModel.assets.filter { $0.part == viewModel.selectedPart }
            let selectedAsset = viewModel.selectedAsset(for: viewModel.selectedPart, index: currentIndex)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3), spacing: 12) {
                ForEach(filteredAssets) { asset in
                    let isSelected = selectedAsset == asset
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(isSelected ? Color("PrimaryBlue") : Color.gray.opacity(0.1))
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
