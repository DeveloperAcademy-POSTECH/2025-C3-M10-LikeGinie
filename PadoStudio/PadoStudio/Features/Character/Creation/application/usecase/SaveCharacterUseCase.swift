//
//  SaveCharacterUseCase.swift
//  PadoStudio
//
//  Created by eunsong on 6/9/25.
//

import Foundation

struct SaveCharacterUseCase {
    let repository: CharacterRepository

    func callAsFunction(_ character: Character) async throws {
        try await repository.save(character)
    }
}
