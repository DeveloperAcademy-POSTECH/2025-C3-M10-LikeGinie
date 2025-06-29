//
//  GalleryFileManager.swift
//  PadoStudio
//
//  Created by eunsong on 6/12/25.
//
import UIKit

enum GalleryFileManager {
    static func save(image: UIImage) throws -> String {
        guard let data = image.pngData() else {
            throw NSError(
                domain: "SaveImageError", code: 1,
                userInfo: [NSLocalizedDescriptionKey: "이미지를 Data로 변환할 수 없음"]
            )
        }

        let fileManager = FileManager.default

        guard
            let documentsURL = fileManager.urls(
                for: .documentDirectory, in: .userDomainMask
            ).first
        else {
            throw NSError(
                domain: "SaveImageError", code: 2,
                userInfo: [NSLocalizedDescriptionKey: "문서 디렉토리를 찾을 수 없음"]
            )
        }

        let galleryURL = documentsURL.appendingPathComponent("gallery", isDirectory: true)

        if !fileManager.fileExists(atPath: galleryURL.path) {
            do {
                try fileManager.createDirectory(
                    at: galleryURL,
                    withIntermediateDirectories: true,
                    attributes: nil
                )
                print("[GalleryFileManager] gallery 디렉토리 생성 성공")
            } catch {
                print("[GalleryFileManager] 디렉토리 생성 오류: \(error.localizedDescription)")
                throw error
            }
        }

        let fileName = UUID().uuidString + ".png"
        let fileURL = galleryURL.appendingPathComponent(fileName)

        do {
            try data.write(to: fileURL)
            print("[GalleryFileManager] 파일 쓰기 성공: \(fileURL.path)")
        } catch {
            print("[GalleryFileManager] 파일 쓰기 오류: \(error.localizedDescription)")
            throw error
        }

        return fileURL.path
    }

    static func delete(imageAtPath path: String) throws {
        let fileManager = FileManager.default
        let fileURL = URL(fileURLWithPath: path)

        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                try fileManager.removeItem(at: fileURL)
                print("[GalleryFileManager] 파일 삭제 성공: \(path)")
            } catch {
                print("[GalleryFileManager] 파일 삭제 오류: \(error.localizedDescription)")
                throw error
            }
        } else {
            print("[GalleryFileManager] 삭제할 파일이 없음: \(path)")
        }
    }
}
