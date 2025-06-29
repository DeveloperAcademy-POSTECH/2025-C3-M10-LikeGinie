//
//  CharacterUseCaseDI.swift
//  PadoStudio
//
//  Created by eunsong on 6/29/25.
//

import Dependencies
import Foundation
import SwiftData

private enum SaveCharacterUseCaseKey: DependencyKey {
    static var liveValue: SaveCharacterUseCase {
        let context = ModelContext(AppModelContainer.shared)
        let ds = DefaultLocalCharacterDatasource(context: context)
        let repo = DefaultCharacterRepository(local: ds)
        return SaveCharacterUseCase(repository: repo)
    }
}

private enum DeleteAllCharactersUseCaseKey: DependencyKey {
    static var liveValue: DeleteAllCharactersUseCase {
        let context = ModelContext(AppModelContainer.shared)
        let ds = DefaultLocalCharacterDatasource(context: context)
        let repo = DefaultCharacterRepository(local: ds)
        return DeleteAllCharactersUseCase(repository: repo)
    }
}

private enum GetCharactersUseCaseKey: DependencyKey {
    static var liveValue: GetCharactersUseCase {
        let context = ModelContext(AppModelContainer.shared)
        let ds = DefaultLocalCharacterDatasource(context: context)
        let repo = DefaultCharacterRepository(local: ds)
        return GetCharactersUseCase(repository: repo)
    }
}

extension DependencyValues {
    var saveCharacterUseCase: SaveCharacterUseCase {
        get { self[SaveCharacterUseCaseKey.self] }
        set { self[SaveCharacterUseCaseKey.self] = newValue }
    }
    var deleteAllCharactersUseCase: DeleteAllCharactersUseCase {
        get { self[DeleteAllCharactersUseCaseKey.self] }
        set { self[DeleteAllCharactersUseCaseKey.self] = newValue }
    }
    var getCharactersUseCase: GetCharactersUseCase {
        get { self[GetCharactersUseCaseKey.self] }
        set { self[GetCharactersUseCaseKey.self] = newValue }
    }
}
