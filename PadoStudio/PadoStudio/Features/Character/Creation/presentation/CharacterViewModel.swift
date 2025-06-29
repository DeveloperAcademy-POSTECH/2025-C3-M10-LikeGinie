import Dependencies
//
//  CharacterViewModel.swift
//  PadoStudio
//
//  Created by eunsong on 5/31/25.
//
import Foundation
import SwiftUI

@MainActor
final class CharacterViewModel: ObservableObject {
    @Dependency(\.saveCharacterUseCase) var saveCharacterUseCase
    @Dependency(\.deleteAllCharactersUseCase) var deleteAllCharactersUseCase
    @Published var selections: [Int: [CharacterPartType: CharacterAsset]] = [:]
    @Published var selectedPart: CharacterPartType = .hair

    let assets: [CharacterAsset] = CharacterAssetMock.mockCharacterAssets

    func select(asset: CharacterAsset, index: Int) {
        if selections[index] == nil {
            selections[index] = [:]
        }
        selections[index]?[asset.part] = asset
    }

    func getPreview(for part: CharacterPartType, index: Int) -> String? {
        selections[index]?[part]?.imageName
    }

    func getOriginImageName(for part: CharacterPartType, index: Int) -> String?
    {
        selections[index]?[part]?.originName
    }

    func selectedAsset(for part: CharacterPartType, index: Int)
        -> CharacterAsset?
    {
        selections[index]?[part]
    }

    func resetCharacter() {
        selections = [:]
    }

    func saveAllCharacterSnapshots(
        count: Int,
        imageSize: CGSize,
        onFinished: @escaping () -> Void
    ) {
        Task {
            let savedPaths = await CharacterSnapshotManager.saveAllSnapshots(
                selections: selections,
                count: count,
                imageSize: imageSize
            )

            await saveCharacterImagePathsToSwiftData(savedPaths)
            onFinished()
        }
    }

    private func saveCharacterImagePathsToSwiftData(_ paths: [String]) async {
        let characterDir = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask
        ).first!.appendingPathComponent("character")
        for index in 0..<paths.count {
            guard let selectedAssets = selections[index] else {
                print("Failed to map to domain character for index \(index).")
                continue
            }
            let path = characterDir.appendingPathComponent(
                "character-preview-\(index).png"
            ).path
            guard
                let character = CharacterMapper.toDomainCharacter(
                    from: selectedAssets, imagePath: path)
            else {
                print("Failed to map to domain character for index \(index).")
                continue
            }

            do {
                try await saveCharacterUseCase(character)
            } catch {
                print("Failed to save character at index \(index): \(error)")
            }
        }
    }
    
    func initializeDefaultSelections(count: Int) {
        
        // 먼저 각 파트별로 디폴트 에셋을 1회만 탐색하여 저장
        var defaultAssetsByPart: [CharacterPartType: CharacterAsset] = [:]

        for part in CharacterPartType.allCases {
            if let defaultAsset = assets.first(where: {
                $0.part == part && ($0.index == "00" || $0.index == "01")
            }) {
                defaultAssetsByPart[part] = defaultAsset
            }
        }

        // 각 인덱스마다 default 에셋을 설정
        for index in 0..<count {
            selections[index] = defaultAssetsByPart
        }
    }

    // 캐릭터 만들기 시작 시 전체 삭제 -> 촬영 완료시 or 앱 시작시로 변경
    func clearCharacterPreviewDirectory() {
        try? CharacterImageStorageManager.removeCharacterDirectoryContents()
    }

    func clearSavedCharactersFromDatabase() async {
        do {
            try await deleteAllCharactersUseCase()
            print("SwiftData 캐릭터 전체 삭제 완료")
        } catch {
            print("SwiftData 삭제 오류: \(error)")
        }
    }
    
    @MainActor
    func resetCharacterCreationSession() async {
        clearCharacterPreviewDirectory()
        await clearSavedCharactersFromDatabase()
        selections = [:]
    }
}
