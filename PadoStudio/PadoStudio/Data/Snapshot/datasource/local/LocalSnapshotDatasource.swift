//
//  LocalSnapshotDatasource.swift
//  PadoStudio
//
//  Created by eunsong on 6/8/25.
//

import Foundation
import SwiftData

protocol LocalSnapshotDatasource {
    func save(snapshot: SnapshotEntity) async throws
    func fetchAll() async throws -> [SnapshotEntity]
    func delete(_ snapshot: SnapshotEntity) async throws
    func get(by id: UUID) async throws -> SnapshotEntity?
}

final class DefaultLocalSnapshotDatasource: LocalSnapshotDatasource {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func save(snapshot: SnapshotEntity) async throws {
        print("[LocalDatasource] SwiftData save() 시작: \(snapshot.id)")
        context.insert(snapshot)
        do {
            try context.save()
            print("[LocalDatasource] SwiftData save() 성공: \(snapshot.id)")
            print("[LocalDatasource] 이미지 경로: \(snapshot.imagePath)")
        } catch {
            print("[LocalDatasource] SwiftData save() 오류: \(error.localizedDescription)")
            print("[LocalDatasource] 오류 상세: \(error)")
            throw error
        }
    }

    func fetchAll() async throws -> [SnapshotEntity] {
        print("[LocalDatasource] SwiftData fetchAll() 시작")
        let descriptor = FetchDescriptor<SnapshotEntity>()
        do {
            let results = try context.fetch(descriptor)
            print("[LocalDatasource] SwiftData fetchAll() 성공: \(results.count)개")
            for result in results {
                print("[LocalDatasource] - ID: \(result.id), 경로: \(result.imagePath)")
            }
            return results
        } catch {
            print("[LocalDatasource] SwiftData fetchAll() 오류: \(error.localizedDescription)")
            print("[LocalDatasource] 오류 상세: \(error)")
            throw error
        }
    }

    func delete(_ snapshot: SnapshotEntity) async throws {
        context.delete(snapshot)
        do {
            try context.save()
            print("[LocalDatasource] SwiftData delete() 성공: \(snapshot.id)")
        } catch {
            print(
                "[LocalDatasource] SwiftData delete() 오류: \(error.localizedDescription)"
            )
            throw error
        }
    }

    func get(by id: UUID) async throws -> SnapshotEntity? {
        let predicate = #Predicate<SnapshotEntity> { $0.id == id }
        var descriptor = FetchDescriptor<SnapshotEntity>(predicate: predicate)
        descriptor.fetchLimit = 1

        do {
            let result = try context.fetch(descriptor).first
            print(
                "[LocalDatasource] SwiftData get(by:) 성공: \(String(describing: result?.id))"
            )
            return result
        } catch {
            print(
                "[LocalDatasource] SwiftData get(by:) 오류: \(error.localizedDescription)"
            )
            throw error
        }
    }
}
