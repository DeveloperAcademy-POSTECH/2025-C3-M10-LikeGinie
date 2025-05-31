//
//  CharacterPartType.swift
//  PadoStudio
//
//  Created by eunsong on 5/31/25.
//


enum CharacterPartType: String, CaseIterable, Hashable {
    case hair, face, suit, board, accessory

    var label: String {
        switch self {
        case .hair: return "헤어"
        case .face: return "얼굴"
        case .suit: return "의상"
        case .board: return "보드"
        case .accessory: return "악세사리"
        }
    }
}
