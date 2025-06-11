//
//  GetAllSnapshotsUseCase.swift
//  PadoStudio
//
//  Created by eunsong on 6/12/25.
//
import Foundation

struct GetAllSnapshotsUseCase {
    let repository: SnapshotRepository

    func execute() async throws -> [Snapshot] {
        try await repository.fetchAll()
    }
}
