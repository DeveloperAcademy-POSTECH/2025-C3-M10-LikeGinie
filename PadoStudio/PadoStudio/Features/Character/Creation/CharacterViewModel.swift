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

    let assets: [CharacterAsset] = CharacterAssetMock.mockCharacterAssets

    func select(asset: CharacterAsset, index: Int) {
        if selections[index] == nil {
            selections[index] = [:]
        }
        selections[index]?[asset.part] = asset
    }

    func getPreview(for part: CharacterPartType, index: Int) -> String? {
        selections[index]?[part]?.imageName
    }
    
    func getOriginImageName(for part: CharacterPartType, index: Int) -> String? {
        selections[index]?[part]?.originName
    }

    func getOriginImageNames(for index: Int) -> [String] {
        selections[index]?.values.map { $0.originName } ?? []
    }

    func selectedAsset(for part: CharacterPartType, index: Int) -> CharacterAsset? {
        selections[index]?[part]
    }
}
