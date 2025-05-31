//
//  CharacterAsset.swift
//  PadoStudio
//
//  Created by eunsong on 5/31/25.
//


struct CharacterAsset: Identifiable, Equatable {
    var id: String { imageName }
    let part: CharacterPartType
    let color: String // 예: "brown", "black"
    let index: String // 예: "03"
    let imageName: String // 예: preview-hair-brown-03

    var originName: String {
        imageName.replacingOccurrences(of: "preview", with: "origin")
    }
    
    static func == (lhs: CharacterAsset, rhs: CharacterAsset) -> Bool {
        return lhs.imageName == rhs.imageName
    }
}
