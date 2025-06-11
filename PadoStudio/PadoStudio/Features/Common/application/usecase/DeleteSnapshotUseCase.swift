//
//  DeleteSnapshotUseCase.swift
//  PadoStudio
//
//  Created by eunsong on 6/12/25.
//
import Foundation

struct DeleteSnapshotUseCase {
    let repository: SnapshotRepository

    func callAsFunction(_ id: UUID) async throws {
        if let snapshot = try await repository.get(by: id) {
            try await repository.delete(snapshot)
        }
    }
}
