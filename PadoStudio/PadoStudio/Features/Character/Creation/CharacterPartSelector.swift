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

        VStack {
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
                .padding(.vertical, 12)
            }
        }
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: -2)
                .mask(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .path(in: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
//                        .asShape()
                )
        )
    }
}

#Preview {
    CharacterPartSelector(viewModel: CharacterViewModel()).background(Color.black)
}
