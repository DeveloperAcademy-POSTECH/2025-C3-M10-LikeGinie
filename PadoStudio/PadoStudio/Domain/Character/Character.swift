//
//  Character.swift
//  PadoStudio
//
//  Created by eunsong on 6/5/25.
//
import Foundation

struct Character {
    let id: UUID
    let partSelections: [CharacterPart: CharacterAssetId]
    let imagePath: String  // 렌더링된 PNG 경로
    let createdAt: Date
}

typealias CharacterAssetId = String
