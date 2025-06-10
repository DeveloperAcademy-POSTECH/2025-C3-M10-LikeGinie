//
//  CharacterRepository.swift
//  PadoStudio
//
//  Created by eunsong on 6/8/25.
//

protocol CharacterRepository {
    func save(_ character: Character) async throws
    func fetchAll() async throws -> [Character]
    func delete(_ character: Character) async throws
    func deleteAll() async throws
}
