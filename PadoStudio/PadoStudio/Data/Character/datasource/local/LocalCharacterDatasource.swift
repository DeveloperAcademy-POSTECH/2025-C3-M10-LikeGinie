//
//  LocalCharacterDatasource.swift
//  PadoStudio
//
//  Created by eunsong on 6/8/25.
//

import Foundation
import SwiftData

protocol LocalCharacterDatasource {
    func save(character: CharacterEntity) async throws
    func fetchAll() async throws -> [CharacterEntity]
    func delete(_ character: CharacterEntity) async throws
}

final class DefaultLocalCharacterDatasource: LocalCharacterDatasource {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func save(character: CharacterEntity) async throws {
        context.insert(character)
        try context.save()
    }

    func fetchAll() async throws -> [CharacterEntity] {
        let descriptor = FetchDescriptor<CharacterEntity>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        return try context.fetch(descriptor)
    }

    func delete(_ character: CharacterEntity) async throws {
        context.delete(character)
        try context.save()
    }
}
