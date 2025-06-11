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
                userInfo: [NSLocalizedDescriptionKey: "이미지를 Data로 변환할 수 없음"])
        }

        let fileManager = FileManager.default

        // Create gallery folder path
        guard
            let documentsURL = fileManager.urls(
                for: .documentDirectory, in: .userDomainMask
            ).first
        else {
            throw NSError(
                domain: "SaveImageError", code: 2,
                userInfo: [NSLocalizedDescriptionKey: "문서 디렉토리를 찾을 수 없음"])
        }

        let galleryURL = documentsURL.appendingPathComponent("gallery", isDirectory: true)

        // Create the gallery folder if it doesn't exist
        if !fileManager.fileExists(atPath: galleryURL.path) {
            try fileManager.createDirectory(at: galleryURL, withIntermediateDirectories: true, attributes: nil)
        }

        let fileName = UUID().uuidString + ".png"
        let fileURL = galleryURL.appendingPathComponent(fileName)

        try data.write(to: fileURL)
        return fileURL.path
    }

    static func delete(imageAtPath path: String) throws {
        let fileManager = FileManager.default
        let fileURL = URL(fileURLWithPath: path)
        if fileManager.fileExists(atPath: fileURL.path) {
            try fileManager.removeItem(at: fileURL)
        }
    }
}
