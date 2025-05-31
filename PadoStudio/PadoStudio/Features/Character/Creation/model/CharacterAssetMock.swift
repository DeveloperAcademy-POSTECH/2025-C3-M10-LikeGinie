//
//  CharacterAssetMock.swift
//  PadoStudio
//
//  Created by eunsong on 6/1/25.
//

import Foundation

struct CharacterAssetMock {
    static let mockCharacterAssets: [CharacterAsset] = [
        // Hair
        .init(
            part: .hair, color: "black", index: "02",
            imageName: "preview-hair-black-02"),
        .init(
            part: .hair, color: "black", index: "03",
            imageName: "preview-hair-black-03"),
        .init(
            part: .hair, color: "black", index: "06",
            imageName: "preview-hair-black-06"),
        .init(
            part: .hair, color: "blond", index: "02",
            imageName: "preview-hair-blond-02"),
        .init(
            part: .hair, color: "blond", index: "03",
            imageName: "preview-hair-blond-03"),
        .init(
            part: .hair, color: "blond", index: "06",
            imageName: "preview-hair-blond-06"),
        .init(
            part: .hair, color: "brown", index: "02",
            imageName: "preview-hair-brown-02"),
        .init(
            part: .hair, color: "brown", index: "03",
            imageName: "preview-hair-brown-03"),
        .init(
            part: .hair, color: "brown", index: "06",
            imageName: "preview-hair-brown-06"),

        // Suit
        .init(
            part: .suit, color: "black", index: "01",
            imageName: "preview-suit-01"),
        .init(
            part: .suit, color: "blue", index: "02",
            imageName: "preview-suit-02"),

        // Board
        .init(
            part: .board, color: "white", index: "01",
            imageName: "preview-board-01"),
        .init(
            part: .board, color: "pink", index: "02",
            imageName: "preview-board-02"),

        // Face (Emotion)
        .init(
            part: .face, color: "default", index: "01",
            imageName: "preview-emotion-01"),

        // Accessory
        .init(
            part: .accessory, color: "yellow", index: "02",
            imageName: "preview-acc-02"),
    ]
}
