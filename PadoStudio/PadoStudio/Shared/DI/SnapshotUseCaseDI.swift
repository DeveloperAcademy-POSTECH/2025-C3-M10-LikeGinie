//
//  SnapshotUseCaseDI.swift
//  PadoStudio
//
//  Created by eunsong on 6/29/25.
//
import Dependencies
import Foundation
import SwiftData

private enum SaveSnapshotUseCaseKey: DependencyKey {
    static var liveValue: SaveSnapshotUseCase {
        let context = ModelContext(AppModelContainer.shared)
        let ds = DefaultLocalSnapshotDatasource(context: context)
        let repo = DefaultSnapshotRepository(local: ds)
        return SaveSnapshotUseCase(repository: repo)
    }
}

private enum DeleteSnapshotUseCaseKey: DependencyKey {
    static var liveValue: DeleteSnapshotUseCase {
        let context = ModelContext(AppModelContainer.shared)
        let ds = DefaultLocalSnapshotDatasource(context: context)
        let repo = DefaultSnapshotRepository(local: ds)
        return DeleteSnapshotUseCase(repository: repo)
    }
}

private enum GetAllSnapshotsUseCaseKey: DependencyKey {
    static var liveValue: GetAllSnapshotsUseCase {
        let context = ModelContext(AppModelContainer.shared)
        let ds = DefaultLocalSnapshotDatasource(context: context)
        let repo = DefaultSnapshotRepository(local: ds)
        return GetAllSnapshotsUseCase(repository: repo)
    }
}

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
