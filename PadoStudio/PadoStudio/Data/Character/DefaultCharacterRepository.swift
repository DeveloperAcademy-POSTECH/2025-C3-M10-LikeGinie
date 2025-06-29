//
//  CharacterRepositoryImpl.swift
//  PadoStudio
//
//  Created by eunsong on 6/8/25.
//
import Foundation
import SwiftData

struct DefaultCharacterRepository: CharacterRepository {
    private let local: LocalCharacterDatasource

    init(local: LocalCharacterDatasource) {
        self.local = local
    }

    func save(_ character: Character) async throws {
        print(">>> save \(character)")
        let entity = CharacterEntity.fromDomainModel(character)
        try await local.save(character: entity)
    }

    func fetchAll() async throws -> [Character] {
        let entities = try await local.fetchAll()
        print(">>> fetchAll \(entities.count)")
        return entities.map { $0.toDomainModel() }
    }

    func delete(_ character: Character) async throws {
        let entity = CharacterEntity.fromDomainModel(character)
        try await local.delete(entity)
    }

    func deleteAll() async throws {
        let allEntities = try await local.fetchAll()
        for entity in allEntities {
            try await local.delete(entity)
        }
    }
}
