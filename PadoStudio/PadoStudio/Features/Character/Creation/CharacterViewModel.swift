//
//  CharacterViewModel.swift
//  PadoStudio
//
//  Created by eunsong on 5/31/25.
//
import SwiftUI

final class CharacterViewModel: ObservableObject {
    @Published var selections: [Int: [CharacterPartType: CharacterAsset]] = [:]
    @Published var selectedPart: CharacterPartType = .hair

    let assets: [CharacterAsset] = [
        CharacterAsset(part: .hair, color: "black", index: "03", imageName: "preview-hair-black-03"),
        CharacterAsset(part: .hair, color: "brown", index: "02", imageName: "preview-hair-brown-02"),
        // 추가
    ]

    func select(asset: CharacterAsset, index: Int) {
        if selections[index] == nil {
            selections[index] = [:]
        }
        selections[index]?[asset.part] = asset
    }

    func getPreview(for part: CharacterPartType, index: Int) -> String? {
        selections[index]?[part]?.imageName
    }

    func getOriginImageNames(for index: Int) -> [String] {
        selections[index]?.values.map { $0.originName } ?? []
    }

    func selectedAsset(for part: CharacterPartType, index: Int) -> CharacterAsset? {
        selections[index]?[part]
    }
}
