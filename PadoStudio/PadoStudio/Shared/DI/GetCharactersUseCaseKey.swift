//
//  GetCharactersUseCaseKey.swift
//  PadoStudio
//
//  Created by eunsong on 6/9/25.
//
import Foundation
import Dependencies
import SwiftData

private enum GetCharactersUseCaseKey: DependencyKey {
    static var liveValue: GetCharactersUseCase {
        let context = ModelContext(CharacterEntityModelContainer.shared)
        let localDatasource = DefaultLocalCharacterDatasource(context: context)
        let repository = DefaultCharacterRepository(local: localDatasource)
        return GetCharactersUseCase(repository: repository)
    }
}

extension DependencyValues {
    var getCharactersUseCase: GetCharactersUseCase {
        get { self[GetCharactersUseCaseKey.self] }
        set { self[GetCharactersUseCaseKey.self] = newValue }
    }
}
