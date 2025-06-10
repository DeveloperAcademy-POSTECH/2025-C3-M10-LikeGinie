//
//  DeleteAllCharactersUseCase.swift
//  PadoStudio
//
//  Created by eunsong on 6/9/25.
//
import Foundation

struct DeleteAllCharactersUseCase {
    let repository: CharacterRepository

    func callAsFunction() async throws {
        try await repository.deleteAll()
    }
}
