//
//  AppModelContainer.swift
//  PadoStudio
//
//  Created by eunsong on 6/29/25.
//

import Foundation
import SwiftData

/// 앱 전체에서 쓰이는 단일 ModelContainer
/// 스토어 파일이 깨졌을 때 삭제 후 재생성하여, 모델-스토어 불일치 문제를 해결합니다.
enum AppModelContainer {
    static let shared: ModelContainer = {
        do {
            // SnapshotEntity와 CharacterEntity를 함께 등록 (varadic 인자 사용)
            return try ModelContainer(
                for: SnapshotEntity.self,
                CharacterEntity.self
            )
        } catch {
            // 깨진 스토어 파일 삭제
            let supportURL = FileManager.default
                .urls(for: .applicationSupportDirectory, in: .userDomainMask)
                .first!
            let storeURL = supportURL.appendingPathComponent("default.store")
            try? FileManager.default.removeItem(at: storeURL)
            // 재시도
            return try! ModelContainer(
                for: SnapshotEntity.self,
                CharacterEntity.self
            )
        }
    }()
}
