//
//  SnapshotRepository.swift
//  PadoStudio
//
//  Created by eunsong on 6/8/25.
//
import Foundation

protocol SnapshotRepository {
    func save(_ snapshot: Snapshot) async throws
    func fetchAll() async throws -> [Snapshot]
    func delete(_ snapshot: Snapshot) async throws
    func get(by id: UUID) async throws -> Snapshot?
}
