//
//  CharacterPartItem.swift
//  PadoStudio
//
//  Created by eunsong on 6/1/25.
//
import SwiftUI

struct CharacterPartItem: View {
    let part: CharacterPartType
    let isSelected: Bool

    var body: some View {
        Text(part.label)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(
                isSelected ? Color.accentColor : Color.gray.opacity(0.2)
            )
            .cornerRadius(12)
            .foregroundColor(isSelected ? .white : .black)
    }
}

#Preview {
    CharacterPartItem(part: .hair, isSelected: true)
}
