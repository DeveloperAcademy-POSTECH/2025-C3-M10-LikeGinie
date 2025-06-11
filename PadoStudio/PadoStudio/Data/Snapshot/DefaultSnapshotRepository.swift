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

    func delete(_ snapshot: Snapshot) async throws {
        let entity = SnapshotEntity.fromDomainModel(snapshot)
        try await local.delete(entity)
    }
    
    func fetchAll() async throws -> [Snapshot] {
        let entities = try await local.fetchAll()
        return entities.map { $0.toDomainModel() }
    }
    func save(_ snapshot: Snapshot) async throws {
        let entity = SnapshotEntity.fromDomainModel(snapshot)
        try await local.save(snapshot: entity)
    }
}
