//
//  GetCharactersUseCase.swift
//  PadoStudio
//
//  Created by eunsong on 6/9/25.
//

import Foundation

struct GetCharactersUseCase {
    let repository: CharacterRepository

    func callAsFunction() async throws -> [Character] {
        try await repository.fetchAll()
    }
}
