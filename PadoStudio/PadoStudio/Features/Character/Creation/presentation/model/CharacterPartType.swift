//
//  CharacterPartType.swift
//  PadoStudio
//
//  Created by eunsong on 5/31/25.
//

enum CharacterPartType: String, CaseIterable, Hashable {
    case hair
    case face
    case suit
    case board
    case headAccessory
    case handAccessory

    var label: String {
        switch self {
        case .hair: return "머리"
        case .face: return "표정"
        case .suit: return "옷"
        case .board: return "서핑보드"
        case .headAccessory: return "얼굴 악세사리"
        case .handAccessory: return "손 악세사리"
        }
    }

    var defaultImageName: String? {
        switch self {
        case .suit: return "preview-suit-01"
        case .face: return "preview-emotion-01"
        case .board: return "preview-board-01"
        case .hair, .headAccessory, .handAccessory: return nil
        }
    }
}
