//
//  SaveSnapshotUseCase.swift
//  PadoStudio
//
//  Created by eunsong on 6/12/25.
//
import Foundation

struct SaveSnapshotUseCase {
    let repository: SnapshotRepository

    func callAsFunction(_ snapshot: Snapshot) async throws {
        do {
            try await repository.save(snapshot)
            print("[SaveSnapshotUseCase] repository.save() 성공")
        } catch {
            print(
                "[SaveSnapshotUseCase] repository.save() 오류: \(error.localizedDescription)"
            )
            throw error
        }
    }
}
