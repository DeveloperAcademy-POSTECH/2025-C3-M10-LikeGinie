//
//  CharacterPartSelector.swift
//  PadoStudio
//
//  Created by eunsong on 6/1/25.
//

import SwiftUI

struct CharacterPartSelector: View {
    @ObservedObject var viewModel: CharacterViewModel
    let proxy: GeometryProxy

    var body: some View {
        let allParts = CharacterPartType.allCases

        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12.scaled) {
                    ForEach(allParts, id: \.self) { part in
                        CharacterPartItem(
                            proxy: proxy,
                            part: part,
                            isSelected: viewModel.selectedPart == part
                        )
                        .onTapGesture {
                            viewModel.selectedPart = part
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 4.scaled)
            }
        }
    }
}

#Preview {
    GeometryReader { proxy in
        CharacterPartSelector(
            viewModel: CharacterViewModel(),
            proxy: proxy
        ).background(Color.gray)
    }
    
}
