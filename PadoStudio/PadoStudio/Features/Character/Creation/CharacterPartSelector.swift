//
//  CharacterPartSelector.swift
//  PadoStudio
//
//  Created by eunsong on 6/1/25.
//

import SwiftUI

struct CharacterPartSelector: View {
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

#Preview {
    CharacterPartSelector(viewModel: CharacterViewModel())
}
