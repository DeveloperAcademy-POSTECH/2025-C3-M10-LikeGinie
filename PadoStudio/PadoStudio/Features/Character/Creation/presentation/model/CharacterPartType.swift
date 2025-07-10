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
        case .hair: return "character_part_hair"
        case .face: return "character_part_face"
        case .suit: return "character_part_suit"
        case .board: return "character_part_board"
        case .headAccessory: return "character_part_head_accessory"
        case .handAccessory: return "character_part_hand_accessory"
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
