//
//  DeleteSnapshotUseCase.swift
//  PadoStudio
//
//  Created by eunsong on 6/12/25.
//
import Foundation

struct DeleteSnapshotUseCase {
    let repository: SnapshotRepository

    func execute(_ snapshot: Snapshot) async throws {
        try await repository.delete(snapshot)
    }
}
