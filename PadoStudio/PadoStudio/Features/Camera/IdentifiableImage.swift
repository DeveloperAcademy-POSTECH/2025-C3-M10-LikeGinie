//
//  IdentifiableImage.swift
//  PadoStudio
//
//  Created by kim yijun on 6/2/25.
//

import Foundation
import UIKit

struct IdentifiableImage: Hashable, Codable {
    let id: UUID
    let image: UIImage

    init(id: UUID = UUID(), image: UIImage) {
        self.id = id
        self.image = image
    }

 
    static func == (lhs: IdentifiableImage, rhs: IdentifiableImage) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    
    enum CodingKeys: String, CodingKey {
        case id
        case imageData
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        let data = try container.decode(Data.self, forKey: .imageData)
        guard let uiImage = UIImage(data: data) else {
            throw DecodingError.dataCorruptedError(forKey: .imageData, in: container, debugDescription: "Invalid image data")
        }
        image = uiImage
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        if let data = image.pngData() {
            try container.encode(data, forKey: .imageData)
        } else {
            throw EncodingError.invalidValue(image, EncodingError.Context(codingPath: encoder.codingPath, debugDescription: "Could not encode image"))
        }
    }
}
