//
//  SnapshotEntity.swift
//  PadoStudio
//
//  Created by eunsong on 6/8/25.
//
import Foundation
import SwiftData

@Model
final class SnapshotEntity {
    var id: UUID
    var characterId: UUID
    var frameId: String
    var imagePath: String
    var createdAt: Date

    init(id: UUID = UUID(), characterId: UUID, frameId: String, imagePath: String, createdAt: Date = .now) {
        self.id = id
        self.characterId = characterId
        self.frameId = frameId
        self.imagePath = imagePath
        self.createdAt = createdAt
    }
}
