//
//  CharacterImageStorageManager.swift
//  PadoStudio
//
//  Created by eunsong on 6/9/25.
//
import UIKit

struct CharacterImageStorageManager {
    static let directory: URL = {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent("character")
    }()

    static func createCharacterDirectory() throws {
        try FileManager.default.createDirectory(
            at: directory, withIntermediateDirectories: true)
    }

    static func removeCharacterDirectory() throws {
        if FileManager.default.fileExists(atPath: directory.path) {
            try FileManager.default.removeItem(at: directory)
        }
    }

    static func save(image: UIImage, at index: Int) throws -> String {
        let filename = directory.appendingPathComponent(
            "character-preview-\(index).png")
        if let data = image.jpegData(compressionQuality: 0.8) {
            try data.write(to: filename)
        }
        return filename.path
    }
}
