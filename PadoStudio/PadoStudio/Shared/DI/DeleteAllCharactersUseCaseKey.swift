//
//  DeleteAllCharactersUseCaseKey.swift
//  PadoStudio
//
//  Created by eunsong on 6/9/25.
//
import Dependencies
import Foundation
import SwiftData

private enum DeleteAllCharactersUseCaseKey: DependencyKey {
    static var liveValue: DeleteAllCharactersUseCase {
        let localDatasource = DefaultLocalCharacterDatasource(
            context: ModelContext(CharacterEntityModelContainer.shared))
        let repository = DefaultCharacterRepository(local: localDatasource)
        return DeleteAllCharactersUseCase(repository: repository)
    }
}

extension DependencyValues {
    var deleteAllCharactersUseCase: DeleteAllCharactersUseCase {
        get { self[DeleteAllCharactersUseCaseKey.self] }
        set { self[DeleteAllCharactersUseCaseKey.self] = newValue }
    }
}
