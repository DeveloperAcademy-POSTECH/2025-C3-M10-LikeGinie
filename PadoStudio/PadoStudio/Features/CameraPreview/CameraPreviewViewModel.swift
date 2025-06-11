//
//  CameraPreviewViewModel.swift
//  PadoStudio
//
//  Created by eunsong on 6/11/25.
//

import SwiftUI
import Dependencies

final class CameraPreviewViewModel: ObservableObject {

    @Dependency(\.saveSnapshotUseCase) var saveSnapshotUseCase

    func saveImageToGallery(
        image: UIImage,
        onSuccess: @escaping (String) -> Void,
        onFailure: @escaping (Error) -> Void
    ) {
        Task {
            do {
                let filePath = try GalleryFileManager.save(image: image)
                let snapshot = Snapshot(id: UUID(), imagePath: filePath, createdAt: Date())
                try await saveSnapshotUseCase(snapshot)
                await MainActor.run {
                    onSuccess(filePath)
                }
            } catch {
                await MainActor.run {
                    onFailure(error)
                }
            }
        }
    }
}
