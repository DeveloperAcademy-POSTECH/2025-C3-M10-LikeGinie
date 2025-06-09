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
        
        // hair default 제거용 X 표시
        CharacterAsset(part: .hair, color: "", index: "00", imageName: "preview-empty"),
        
        CharacterAsset(part: .hair, color: "black", index: "01", imageName: "preview-hair-black-01"),
        CharacterAsset(part: .hair, color: "black", index: "02", imageName: "preview-hair-black-02"),
        CharacterAsset(part: .hair, color: "black", index: "03", imageName: "preview-hair-black-03"),
        CharacterAsset(part: .hair, color: "black", index: "04", imageName: "preview-hair-black-04"),
        CharacterAsset(part: .hair, color: "blond", index: "01", imageName: "preview-hair-blond-01"),
        CharacterAsset(part: .hair, color: "blond", index: "02", imageName: "preview-hair-blond-02"),
        CharacterAsset(part: .hair, color: "blond", index: "03", imageName: "preview-hair-blond-03"),
        CharacterAsset(part: .hair, color: "blond", index: "04", imageName: "preview-hair-blond-04"),
        CharacterAsset(part: .hair, color: "brown", index: "01", imageName: "preview-hair-brown-01"),
        CharacterAsset(part: .hair, color: "brown", index: "02", imageName: "preview-hair-brown-02"),
        CharacterAsset(part: .hair, color: "brown", index: "03", imageName: "preview-hair-brown-03"),
        CharacterAsset(part: .hair, color: "brown", index: "04", imageName: "preview-hair-brown-04"),

        // face (표정)
        CharacterAsset(part: .face, color: "", index: "01", imageName: "preview-emotion-01"),
        CharacterAsset(part: .face, color: "", index: "02", imageName: "preview-emotion-02"),
        CharacterAsset(part: .face, color: "", index: "03", imageName: "preview-emotion-03"),
        CharacterAsset(part: .face, color: "", index: "04", imageName: "preview-emotion-04"),
        CharacterAsset(part: .face, color: "", index: "05", imageName: "preview-emotion-05"),
        CharacterAsset(part: .face, color: "", index: "06", imageName: "preview-emotion-06"),

        // suit (옷)
        CharacterAsset(part: .suit, color: "", index: "01", imageName: "preview-suit-01"),
        CharacterAsset(part: .suit, color: "", index: "02", imageName: "preview-suit-02"),
        CharacterAsset(part: .suit, color: "", index: "03", imageName: "preview-suit-03"),
        CharacterAsset(part: .suit, color: "", index: "04", imageName: "preview-suit-04"),
        CharacterAsset(part: .suit, color: "", index: "05", imageName: "preview-suit-05"),
        CharacterAsset(part: .suit, color: "", index: "06", imageName: "preview-suit-06"),

        // board (서핑보드)
        CharacterAsset(part: .board, color: "", index: "01", imageName: "preview-board-01"),
        CharacterAsset(part: .board, color: "", index: "02", imageName: "preview-board-02"),
        CharacterAsset(part: .board, color: "", index: "03", imageName: "preview-board-03"),
        CharacterAsset(part: .board, color: "", index: "04", imageName: "preview-board-04"),
        CharacterAsset(part: .board, color: "", index: "05", imageName: "preview-board-05"),
        CharacterAsset(part: .board, color: "", index: "06", imageName: "preview-board-06"),
        
        // 악세서리
        // head accessory (얼굴 악세사리)
        CharacterAsset(part: .headAccessory, color: "", index: "00", imageName: "preview-empty"),
        CharacterAsset(part: .headAccessory, color: "", index: "01", imageName: "preview-head-acc-01"),
        CharacterAsset(part: .headAccessory, color: "", index: "02", imageName: "preview-head-acc-02"),
        CharacterAsset(part: .headAccessory, color: "", index: "03", imageName: "preview-head-acc-03"),
        CharacterAsset(part: .headAccessory, color: "", index: "04", imageName: "preview-head-acc-04"),

        // hand accessory (손 악세사리)
        CharacterAsset(part: .handAccessory, color: "", index: "00", imageName: "preview-empty"),
        CharacterAsset(part: .handAccessory, color: "", index: "01", imageName: "preview-body-acc-01"),
        CharacterAsset(part: .handAccessory, color: "", index: "02", imageName: "preview-body-acc-02"),
        CharacterAsset(part: .handAccessory, color: "", index: "03", imageName: "preview-body-acc-03"),
        CharacterAsset(part: .handAccessory, color: "", index: "04", imageName: "preview-body-acc-04"),

    ]
}
