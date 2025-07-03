//
//  SnapshotRepositoryImpl.swift
//  PadoStudio
//
//  Created by eunsong on 6/8/25.
//
import Foundation
import SwiftData

struct DefaultSnapshotRepository: SnapshotRepository {
    private let local: LocalSnapshotDatasource

    init(local: LocalSnapshotDatasource) {
        self.local = local
    }

    func delete(id: UUID) async throws {
        if let managedEntity = try await local.get(by: id) {
            try await local.delete(managedEntity)
        }
    }

    func fetchAll() async throws -> [Snapshot] {
        let entities = try await local.fetchAll()
        return entities.map { $0.toDomainModel() }
    }
    func save(_ snapshot: Snapshot) async throws {
        let entity = SnapshotEntity.fromDomainModel(snapshot)
        try await local.save(snapshot: entity)
    }
    func get(by id: UUID) async throws -> Snapshot? {
        let entity = try await local.get(by: id)
        return entity?.toDomainModel()
    }
}
