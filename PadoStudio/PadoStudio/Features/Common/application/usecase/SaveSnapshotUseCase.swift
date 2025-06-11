//
//  SaveSnapshotUseCase.swift
//  PadoStudio
//
//  Created by eunsong on 6/12/25.
//
import Foundation

struct SaveSnapshotUseCase {
    let repository: SnapshotRepository

    func execute(_ snapshot: Snapshot) async throws {
        try await repository.save(snapshot)
    }
}
