//
//  CharacterMapper.swift
//  PadoStudio
//
//  Created by eunsong on 6/9/25.
//

import Foundation

enum CharacterMapper {
    static func toDomainCharacter(
        from selections: [CharacterPartType: CharacterAsset],
        imagePath: String
    ) -> Character? {
        guard !selections.isEmpty else { return nil }

        let mappedPairs: [(CharacterPart, CharacterAssetId)] = selections.compactMap { partType, asset in
            guard let part = CharacterPart(rawValue: partType.rawValue) else { return nil }
            return (part, asset.imageName)
        }
        let partSelections: [CharacterPart: CharacterAssetId] = Dictionary(uniqueKeysWithValues: mappedPairs)

        return Character(
            id: UUID(),
            partSelections: partSelections,
            imagePath: imagePath,
            createdAt: Date()
        )
    }
}
