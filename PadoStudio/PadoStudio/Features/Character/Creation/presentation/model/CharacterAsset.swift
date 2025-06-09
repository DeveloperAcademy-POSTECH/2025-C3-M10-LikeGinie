//
//  CharacterAsset.swift
//  PadoStudio
//
//  Created by eunsong on 5/31/25.
//
import Foundation

struct CharacterAsset: Identifiable, Equatable {
    var id: String { imageName }
    let part: CharacterPartType
    let color: String // 예: "brown", "black", "none"
    let index: String // 예: "03", "01", "x"
    let imageName: String // 예: preview-hair-brown-03

    var originName: String {
        imageName.replacingOccurrences(of: "preview", with: "origin")
    }

    var isDefault: Bool {
        imageName == part.defaultImageName
    }

    static func == (lhs: CharacterAsset, rhs: CharacterAsset) -> Bool {
        lhs.imageName == rhs.imageName
    }
}
