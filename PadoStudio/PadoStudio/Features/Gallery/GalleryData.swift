//
//  GalleryData.swift
//  PadoStudio
//
//  Created by gabi on 6/5/25.
//

import Foundation

class GalleryData {
    var id: UUID
    var date: Date
    var filePath: String

    init(id: UUID = UUID(), date: Date = Date(), filePath: String) {
        self.id = UUID()
        self.date = date
        self.filePath = filePath
    }
}

extension GalleryData {
    static func from(snapshot: Snapshot) -> GalleryData {
        return GalleryData(
            id: snapshot.id,
            date: snapshot.createdAt,
            filePath: snapshot.imagePath
        )
    }
}
