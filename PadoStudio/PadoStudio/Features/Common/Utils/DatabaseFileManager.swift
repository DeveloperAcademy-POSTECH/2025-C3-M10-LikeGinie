//
//  DatabaseFileManager.swift
//  PadoStudio
//
//  Created by eunsong on 6/29/25.
//

import Foundation

struct DatabaseFileManager {
    /// Application Support/default.store 파일 경로
    static var storeURL: URL {
        let support = FileManager.default
            .urls(for: .applicationSupportDirectory, in: .userDomainMask)
            .first!
        return support.appendingPathComponent(
            "default.store", isDirectory: false)
    }

    /// default.store 파일만 삭제
    static func removeStoreFileIfExists() {
        let fm = FileManager.default
        let url = storeURL
        guard fm.fileExists(atPath: url.path) else {
            print("DatabaseFileManager: 삭제할 스토어 없음: \(url.path)")
            return
        }
        do {
            try fm.removeItem(at: url)
            print("DatabaseFileManager: 스토어 파일 삭제 완료: \(url.path)")
        } catch {
            print(
                "DatabaseFileManager: 스토어 파일 삭제 오류: \(error.localizedDescription)"
            )
        }
    }
}
