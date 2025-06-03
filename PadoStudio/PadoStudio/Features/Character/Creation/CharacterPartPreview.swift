//
//  CharacterPartPreview.swift
//  PadoStudio
//
//  Created by eunsong on 6/1/25.
//
import SwiftUI

// Helper view to break down ZStack ForEach content for compiler
struct CharacterPartPreview: View {
    let part: CharacterPartType
    let previewName: String?

    var body: some View {
        // Assign previewName to a local variable for clarity (already passed as prop)
        let finalName = previewName //?? part.defaultImageName
        if let name = finalName {
            Image(name)
                .resizable()
                .scaledToFit()
        }
    }
}

#Preview {
    CharacterPartPreview(part: .hair, previewName: "preview-hair-black-01")
}
