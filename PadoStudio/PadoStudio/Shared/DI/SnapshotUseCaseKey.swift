//
//  SaveSnapshotUseCaseKey.swift
//  PadoStudio
//
//  Created by eunsong on 6/12/25.
//

import Dependencies
import Foundation
import SwiftData

extension DependencyValues {
    var saveSnapshotUseCase: SaveSnapshotUseCase {
        get { self[SaveSnapshotUseCaseKey.self] }
        set { self[SaveSnapshotUseCaseKey.self] = newValue }
    }

    var deleteSnapshotUseCase: DeleteSnapshotUseCase {
        get { self[DeleteSnapshotUseCaseKey.self] }
        set { self[DeleteSnapshotUseCaseKey.self] = newValue }
    }

    var getAllSnapshotsUseCase: GetAllSnapshotsUseCase {
        get { self[GetAllSnapshotsUseCaseKey.self] }
        set { self[GetAllSnapshotsUseCaseKey.self] = newValue }
    }
}

enum SnapshotEntityModelContainer {
    static let shared: ModelContainer = {
        do {
            return try ModelContainer(for: SnapshotEntity.self)
        } catch {
            let storeURL = URL.applicationSupportDirectory.appending(path: "default.store")
            try? FileManager.default.removeItem(at: storeURL)
            do {
                return try ModelContainer(for: SnapshotEntity.self)
            } catch {
                fatalError("Failed to create ModelContainer for SnapshotEntity after resetting store: \(error)")
            }
        }
    }()
}

private enum SaveSnapshotUseCaseKey: DependencyKey {
    static var liveValue: SaveSnapshotUseCase {
        let localDataSource = DefaultLocalSnapshotDatasource(
            context: ModelContext(SnapshotEntityModelContainer.shared)
        )
        let repository = DefaultSnapshotRepository(local: localDataSource)
        return SaveSnapshotUseCase(repository: repository)
    }
}

private enum DeleteSnapshotUseCaseKey: DependencyKey {
    static var liveValue: DeleteSnapshotUseCase {
        let localDataSource = DefaultLocalSnapshotDatasource(
            context: ModelContext(SnapshotEntityModelContainer.shared)
        )
        let repository = DefaultSnapshotRepository(local: localDataSource)
        return DeleteSnapshotUseCase(repository: repository)
    }
}

private enum GetAllSnapshotsUseCaseKey: DependencyKey {
    static var liveValue: GetAllSnapshotsUseCase {
        let localDataSource = DefaultLocalSnapshotDatasource(
            context: ModelContext(SnapshotEntityModelContainer.shared)
        )
        let repository = DefaultSnapshotRepository(local: localDataSource)
        return GetAllSnapshotsUseCase(repository: repository)
    }
}
