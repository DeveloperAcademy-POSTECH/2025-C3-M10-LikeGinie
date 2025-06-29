//
//  CameraPreviewViewModel.swift
//  PadoStudio
//
//  Created by eunsong on 6/11/25.
//

import Dependencies
import SwiftUI

final class CameraPreviewViewModel: ObservableObject {

    @Dependency(\.saveSnapshotUseCase) var saveSnapshotUseCase

    func saveImageToGallery(
        image: UIImage,
        onSuccess: @escaping (String) -> Void,
        onFailure: @escaping (Error) -> Void
    ) {
        Task {
            do {
                // 파일 쓰기
                let filePath = try GalleryFileManager.save(image: image)
                print("파일 저장 완료: \(filePath)")

                // DB에 스냅샷 저장
                let snapshot = Snapshot(
                    id: UUID(), imagePath: filePath, createdAt: Date())
                print(">> create snapshot: \(snapshot)")
                try await saveSnapshotUseCase(snapshot)

                await MainActor.run {
                    onSuccess(filePath)
                }
            } catch {
                print("저장 중 Error: \(error.localizedDescription)")
                await MainActor.run {
                    onFailure(error)
                }
            }
        }
    }
}
