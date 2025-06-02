//
//  CharacterPreviewPager.swift
//  PadoStudio
//
//  Created by eunsong on 6/1/25.
//
import SwiftUI

struct CharacterPreviewPager: View {
    let number: Int
    @Binding var currentIndex: Int
    @ObservedObject var viewModel: CharacterViewModel

    var body: some View {
        ZStack {
            // 배경색
            Color.primaryBlue
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Image("bg")
                    .resizable()
//                    .scaledToFit()
                    .frame(maxWidth: .infinity)
            }
            .ignoresSafeArea(edges: .bottom)
            
            
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
                    (
                        part,
                        viewModel.getOriginImageName(for: part, index: currentIndex)
                    )
                }

                ZStack {
                    Image("origin-standard")
                        .resizable()
                        .scaledToFit()

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
}

#Preview {
    CharacterPreviewPager(
        number: 3, currentIndex: .constant(0), viewModel: CharacterViewModel())
}
