//
//  CharacterCreationDIContainer.swift
//  PadoStudio
//
//  Created by eunsong on 6/9/25.

import Dependencies
import Foundation
import SwiftData

enum CharacterEntityModelContainer {
    static let shared: ModelContainer = {
        try! ModelContainer(for: CharacterEntity.self)
    }()
}

private enum SaveCharacterUseCaseKey: DependencyKey {
    static var liveValue: SaveCharacterUseCase {
        // TODO: Pass ModelContext from the View instead of resolving it here
        let localDatasource = DefaultLocalCharacterDatasource(
            context: ModelContext(CharacterEntityModelContainer.shared))
        let repository = DefaultCharacterRepository(local: localDatasource)
        return SaveCharacterUseCase(repository: repository)
    }
}

extension DependencyValues {
    var saveCharacterUseCase: SaveCharacterUseCase {
        get { self[SaveCharacterUseCaseKey.self] }
        set { self[SaveCharacterUseCaseKey.self] = newValue }
    }
}
