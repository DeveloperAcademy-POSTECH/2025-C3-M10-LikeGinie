//
//  CharacterEntity.swift
//  PadoStudio
//
//  Created by eunsong on 6/8/25.
//
import Foundation
import SwiftData

@Model
final class CharacterEntity {
    @Attribute(.unique) var id: UUID
    var partSelections: [String: String]
    var imagePath: String
    var createdAt: Date

    init(
        id: UUID = UUID(), partSelections: [String: String], imagePath: String,
        createdAt: Date = .now
    ) {
        self.id = id
        self.partSelections = partSelections
        self.imagePath = imagePath
        self.createdAt = createdAt
    }
}

extension CharacterEntity {
    func toDomainModel() -> Character {
        let convertedSelections: [CharacterPart: CharacterAssetId] = Dictionary(
            uniqueKeysWithValues: self.partSelections.compactMap { key, value in
                guard let part = CharacterPart(rawValue: key) else {
                    return nil
                }
                return (part, value)
            }
        )

        return Character(
            id: self.id,
            partSelections: convertedSelections,
            imagePath: self.imagePath,
            createdAt: self.createdAt
        )
    }

    static func fromDomainModel(_ model: Character) -> CharacterEntity {
        let stringKeySelections: [String: String] = Dictionary(
            uniqueKeysWithValues: model.partSelections.map {
                ($0.key.rawValue, $0.value)
            }
        )

        return CharacterEntity(
            id: model.id,
            partSelections: stringKeySelections,
            imagePath: model.imagePath,
            createdAt: model.createdAt
        )
    }
}
