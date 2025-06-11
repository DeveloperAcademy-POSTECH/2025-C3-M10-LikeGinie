//
//  PhotoDetailViewModel.swift
//  PadoStudio
//
//  Created by eunsong on 6/12/25.
//
import Dependencies
import Foundation
import SwiftUI

final class PhotoDetailViewModel: ObservableObject {
    @Dependency(\.deleteSnapshotUseCase) var deleteSnapshotUseCase

    func deleteSnapshot(_ snapshot: GalleryData) async {
        do {
            try await deleteSnapshotUseCase(snapshot.id)
            try GalleryFileManager.delete(imageAtPath: snapshot.filePath)
        } catch {
            print("삭제 실패: \(error)")
        }
    }
}
