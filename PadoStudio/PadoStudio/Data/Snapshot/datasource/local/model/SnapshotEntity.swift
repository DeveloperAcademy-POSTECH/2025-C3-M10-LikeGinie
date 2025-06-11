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
    var imagePath: String
    var createdAt: Date

    init(id: UUID = UUID(), imagePath: String, createdAt: Date = .now) {
        self.id = id
        self.imagePath = imagePath
        self.createdAt = createdAt
    }
}

extension SnapshotEntity {
    func toDomainModel() -> Snapshot {
        return Snapshot(
            id: id,
            imagePath: imagePath,
            createdAt: createdAt
        )
    }

    static func fromDomainModel(_ model: Snapshot) -> SnapshotEntity {
        return SnapshotEntity(
            id: model.id,
            imagePath: model.imagePath,
            createdAt: model.createdAt
        )
    }
}
