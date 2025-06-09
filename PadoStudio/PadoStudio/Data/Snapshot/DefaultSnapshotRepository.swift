//
//  SnapshotRepositoryImpl.swift
//  PadoStudio
//
//  Created by eunsong on 6/8/25.
//
import Foundation
import SwiftData

struct DefualtSnapshotRepository: SnapshotRepository {
    let context: ModelContext

    func save(_ snapshot: Snapshot) async throws {
        context.insert(
            SnapshotEntity(
                id: snapshot.id,
                characterId: snapshot.characterId,
                frameId: snapshot.frameId,
                imagePath: snapshot.imagePath,
                createdAt: snapshot.createdAt
            ))
    }

    func fetchAll() async throws -> [Snapshot] {
        try context.fetch(FetchDescriptor<SnapshotEntity>()).map {
            Snapshot(
                id: $0.id, characterId: $0.characterId, frameId: $0.frameId,
                imagePath: $0.imagePath, createdAt: $0.createdAt)
        }
    }

    func delete(_ snapshot: Snapshot) async throws {
        let targetId = snapshot.id
        let descriptor = FetchDescriptor<SnapshotEntity>(
            predicate: #Predicate { $0.id == targetId }
        )
        if let model = try context.fetch(descriptor).first {
            context.delete(model)
        }
    }
}
