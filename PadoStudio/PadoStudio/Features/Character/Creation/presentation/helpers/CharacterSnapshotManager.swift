//
//  CharacterSnapshotManager.swift
//  PadoStudio
//
//  Created by eunsong on 6/9/25.
//
import SwiftUI

enum CharacterSnapshotManager {

    /// selections 에 담긴 캐릭터 정보를 기반으로
    /// 0..<count 인덱스별 뷰를 렌더링하고 파일로 저장한 뒤
    /// 저장된 경로 배열을 반환합니다.
    static func saveAllSnapshots(
        selections: [Int: [CharacterPartType: CharacterAsset]],
        count: Int,
        imageSize: CGSize
    ) async -> [String] {
        var savedPaths: [String] = []

        // 1) 폴더 준비
        do {
            try CharacterImageStorageManager.ensureDirectoryExists()
            print("[CharacterSnapshotManager] 캐릭터 폴더 준비 완료")
        } catch {
            print(
                "[CharacterSnapshotManager] 폴더 준비 실패: \(error.localizedDescription)"
            )
            return []
        }

        // 2) 인덱스별로 스냅샷 생성·저장
        for index in 0..<count {
            guard let partDict = selections[index] else {
                print("[CharacterSnapshotManager] 선택 정보 없음: index \(index)")
                continue
            }

            // 파트별 원본 이름 매핑
            var imageNames: [CharacterPartType: String] = [:]
            for part in CharacterPartType.allCases {
                if let name = partDict[part]?.originName {
                    imageNames[part] = name
                }
            }

            // 뷰 렌더링
            let previewView = CharacterPreviewStackView(
                currentIndex: index,
                imageNames: imageNames,
                imageSize: imageSize
            )
            let optionalImage =
                await SnapshotRendererHelper.renderCharacterPreview(
                    from: previewView,
                    size: imageSize
                )

            // 이미지 저장
            guard let image = optionalImage else {
                print("[CharacterSnapshotManager] 렌더링된 이미지가 없음: index \(index)")
                continue
            }

            // 4) 저장 시도
            do {
                let path = try CharacterImageStorageManager.save(
                    image: image, at: index)
                print(
                    "[CharacterSnapshotManager] 스냅샷 저장 성공: index \(index), 경로 \(path)"
                )
                savedPaths.append(path)
            } catch {
                print(
                    "[CharacterSnapshotManager] 스냅샷 저장 오류: index \(index), \(error.localizedDescription)"
                )
            }
        }

        return savedPaths
    }
}
