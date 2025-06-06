//
//  ImageData.swift
//  LikeGinie
//
//  Created by 윤민경 on 5/28/25.
//

import Foundation

struct ImageData: Identifiable {
    let id = UUID()
    let name: String
}

class ImageDataService {
    static func fetchImages() -> [ImageData] {
        return [
            ImageData(name: "sample_character_01"),
            ImageData(name: "sample_character_02"),
            ImageData(name: "sample_character_03"),
            ImageData(name: "sample_character_04"),
            ImageData(name: "sample_character_05"),
            ImageData(name: "sample_character_06")
        ]
    }
}


