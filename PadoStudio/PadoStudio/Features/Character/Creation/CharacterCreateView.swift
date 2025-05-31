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
            CharacterPreviewPager(
                number: number, currentIndex: $currentIndex,
                viewModel: viewModel)

            CharacterPartSelector(viewModel: viewModel)

            CharacterAssetGrid(viewModel: viewModel, currentIndex: currentIndex)
        }
        .padding()
    }
}

#Preview("CharacterCreateView") {
    CharacterCreateView(number: 3)
}
