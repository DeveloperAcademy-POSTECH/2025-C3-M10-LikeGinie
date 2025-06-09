//
//  CharacterPreviewStackView.swift
//  PadoStudio
//
//  Created by eunsong on 6/9/25.
//
import SwiftUI

struct CharacterPreviewStackView: View {
    let currentIndex: Int
    let imageNames: [CharacterPartType: String]
    let imageSize: CGSize

    var body: some View {
        ZStack {
            Color.clear
            Image("origin-standard")
                .resizable()
                .scaledToFit()

            ForEach(CharacterPartType.allCases, id: \.self) { part in
                if let name = imageNames[part] {
                    CharacterPartPreview(
                        part: part,
                        previewName: name
                    )
                }
            }
        }
        .frame(width: imageSize.width, height: imageSize.width)
    }
}
