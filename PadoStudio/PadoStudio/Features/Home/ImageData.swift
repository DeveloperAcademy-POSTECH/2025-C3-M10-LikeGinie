//
//  ImageData.swift
//  LikeGinie
//
//  Created by 윤민경 on 5/28/25.
//

// ImageData.swift
import Foundation

// 데이터 모델
struct ImageData: Identifiable {
    let id = UUID()
    let name: String
}

// 데이터 서비스
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
