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
    let proxy: GeometryProxy

    var body: some View {
        VStack {
            HStack {
                leftArrowButton
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white)
                        .shadow(radius: 4)

                    characterPreviewStack
                        .padding(.horizontal)
                }
                .frame(
                    width: proxy.size.width * 0.5,
                    height: proxy.size.height * 0.3)

                rightArrowButton
            }
            .padding(.horizontal, 24)

            HStack(spacing: 8) {
                ForEach(0..<number, id: \.self) { index in
                    Circle()
                        .fill(
                            index == currentIndex
                                ? Color.primaryGreen : Color.gray05
                        )
                        .frame(width: 8, height: 8)
                }
            }
            .padding(.top, 8)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 24)
    }

    private var leftArrowButton: some View {
        Button(action: viewModel.prevPage) {
            Image(systemName: "chevron.left")
                .foregroundColor(.white)
                .font(.system(size: 24, weight: .bold))
                .padding()
        }
        .opacity(currentIndex > 0 ? 1 : 0)
    }

    private var rightArrowButton: some View {
        Button(action: { viewModel.nextPage(count: number) }) {
            Image(systemName: "chevron.right")
                .foregroundColor(.white)
                .font(.system(size: 24, weight: .bold))
                .padding()
        }
        .opacity(currentIndex < number - 1 ? 1 : 0)
    }

    private var characterPreviewStack: some View {
        let previews = CharacterPartType.allCases.map { part in
            (
                part,
                viewModel.getOriginImageName(for: part, index: currentIndex)
            )
        }

        return ZStack {
            Image("origin-standard")
                .resizable()
                .scaledToFit()

            ForEach(previews, id: \.0) { part, name in
                CharacterPartPreview(part: part, previewName: name)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    GeometryReader { proxy in
        CharacterPreviewPager(
            number: 3, currentIndex: .constant(0),
            viewModel: CharacterViewModel(), proxy: proxy
        ).background(Color.gray)
    }
}
