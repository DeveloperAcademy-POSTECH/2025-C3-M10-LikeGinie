//
//  FrameImageCacheManager.swift
//  PadoStudio
//
//  Created by eunsong on 6/11/25.
//

import UIKit

struct FrameImageCacheManager {
    static let directory: URL = {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent("frame")
    }()

    static func createFrameDirectory() throws {
        try FileManager.default.createDirectory(
            at: directory, withIntermediateDirectories: true)
    }

    static func removeFrameDirectory() throws {
        if FileManager.default.fileExists(atPath: directory.path) {
            try FileManager.default.removeItem(at: directory)
        }
    }

    static func save(image: UIImage, named name: String) throws -> String {
        let filename = directory.appendingPathComponent(
            "frame-preview-\(name).png")
        if let data = image.pngData() {
            try data.write(to: filename)
        }
        print("frame saved \(filename.path)")
        return filename.path
    }

    static func imagePath(for name: String) -> String {
        return directory.appendingPathComponent("frame-preview-\(name).png")
            .path
    }
}
