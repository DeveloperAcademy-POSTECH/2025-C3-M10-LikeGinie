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
            ImageData(name: "home1"),
            ImageData(name: "home2"),
            ImageData(name: "home3"),
            ImageData(name: "home4"),
            ImageData(name: "home5"),
            ImageData(name: "home6")
        ]
    }
}
