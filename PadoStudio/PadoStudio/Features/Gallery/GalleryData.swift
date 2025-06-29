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
        self.id = id // UUID() 대신 매개변수로 받은 id 사용
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
