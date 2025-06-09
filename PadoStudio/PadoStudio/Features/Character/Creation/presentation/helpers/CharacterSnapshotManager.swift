//
//  CharacterSnapshotManager.swift
//  PadoStudio
//
//  Created by eunsong on 6/9/25.
//
import SwiftUI

enum CharacterSnapshotManager {

    static func saveAllSnapshots(
        selections: [Int: [CharacterPartType: CharacterAsset]],
        count: Int,
        imageSize: CGSize
    ) async -> [String] {
        var savedPaths: [String] = []

        do {
            try CharacterImageStorageManager.createCharacterDirectory()
        } catch {
            print("디렉토리 생성 실패: \(error)")
            return []
        }

        for index in 0..<count {
            guard let partDict = selections[index] else { continue }
            var imageNames: [CharacterPartType: String] = [:]

            for part in CharacterPartType.allCases {
                if let name = partDict[part]?.originName {
                    imageNames[part] = name
                }
            }

            let view = CharacterPreviewStackView(
                currentIndex: index,
                imageNames: imageNames,
                imageSize: imageSize
            )

            let image = await SnapshotRendererHelper.renderCharacterPreview(
                from: view, size: imageSize)

            if let image,
                let path = try? CharacterImageStorageManager.save(
                    image: image, at: index)
            {
                print("saved path : \(path)")
                savedPaths.append(path)
            } else {
                print("스냅샷 저장 실패: index \(index)")
            }
        }

        return savedPaths
    }
}
