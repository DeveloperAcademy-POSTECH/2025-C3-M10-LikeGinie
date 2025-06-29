//
//  CharacterImageStorageManager.swift
//  PadoStudio
//
//  Created by eunsong on 6/9/25.
//
import UIKit

struct CharacterImageStorageManager {
    /// Document 디렉토리 하위의 character 폴더
    static let directory: URL = {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("character", isDirectory: true)
    }()

    /// character 폴더가 없으면 만들고, 있으면 넘어갑니다.
    static func ensureDirectoryExists() throws {
        let fm = FileManager.default
        if !fm.fileExists(atPath: directory.path) {
            do {
                try fm.createDirectory(
                    at: directory,
                    withIntermediateDirectories: true,
                    attributes: nil
                )
                print("[CharacterImageStorageManager] 폴더 생성: \(directory.path)")
            } catch {
                print(
                    "[CharacterImageStorageManager] 폴더 생성 오류: \(error.localizedDescription)"
                )
                throw error
            }
        } else {
            print("[CharacterImageStorageManager] 폴더 이미 존재: \(directory.path)")
        }
    }

    static func removeCharacterDirectoryContents() throws {
        let fm = FileManager.default

        // character 폴더가 없으면 할 일 없음
        guard fm.fileExists(atPath: directory.path) else {
            print("[CharacterImageStorageManager] 삭제할 폴더 없음: \(directory.path)")
            return
        }

        do {
            // 폴더 내부의 모든 URL 가져오기
            let contents = try fm.contentsOfDirectory(
                at: directory,
                includingPropertiesForKeys: nil,
                options: []
            )

            // 각 항목 삭제
            for url in contents {
                do {
                    try fm.removeItem(at: url)
                    print("[CharacterImageStorageManager] 항목 삭제: \(url.path)")
                } catch {
                    print(
                        "[CharacterImageStorageManager] 항목 삭제 오류: \(error.localizedDescription)"
                    )
                    // 원한다면 여기서 바로 throw 해도 되고, 로그만 남기고 계속 진행해도 됩니다.
                }
            }
        } catch {
            print(
                "[CharacterImageStorageManager] 폴더 내용 읽기 오류: \(error.localizedDescription)"
            )
            throw error
        }
    }

    /// index 기반 파일명으로 저장하고, 경로를 반환합니다.
    static func save(image: UIImage, at index: Int) throws -> String {
        // 1) 폴더 확인/생성
        try ensureDirectoryExists()

        // 2) 파일 쓰기
        let fileURL =
            directory
            .appendingPathComponent("character-preview-\(index).png")

        guard let data = image.pngData() else {
            let error = NSError(
                domain: "CharacterImageStorageError",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "이미지 데이터를 생성할 수 없음"]
            )
            print("[CharacterImageStorageManager] 데이터 변환 오류")
            throw error
        }

        do {
            try data.write(to: fileURL)
            print("[CharacterImageStorageManager] 파일 저장 성공: \(fileURL.path)")
            return fileURL.path
        } catch {
            print(
                "[CharacterImageStorageManager] 파일 저장 오류: \(error.localizedDescription)"
            )
            throw error
        }
    }
}
