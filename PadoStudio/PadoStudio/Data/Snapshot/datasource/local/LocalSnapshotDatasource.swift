//
//  LocalSnapshotDatasource.swift
//  PadoStudio
//
//  Created by eunsong on 6/8/25.
//

import SwiftData

protocol LocalSnapshotDatasource {
    func save(snapshot: SnapshotEntity) async throws
    func fetchAll() async throws -> [SnapshotEntity]
    func delete(_ snapshot: SnapshotEntity) async throws
}

final class DefaultLocalSnapshotDatasource: LocalSnapshotDatasource {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func save(snapshot: SnapshotEntity) async throws {
        context.insert(snapshot)
        try context.save()
    }

    func fetchAll() async throws -> [SnapshotEntity] {
        let descriptor = FetchDescriptor<SnapshotEntity>()
        return try context.fetch(descriptor)
    }

    func delete(_ snapshot: SnapshotEntity) async throws {
        context.delete(snapshot)
        try context.save()
    }
}
