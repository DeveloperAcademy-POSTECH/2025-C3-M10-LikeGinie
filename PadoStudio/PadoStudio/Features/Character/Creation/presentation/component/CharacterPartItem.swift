//
//  CharacterPartItem.swift
//  PadoStudio
//
//  Created by eunsong on 6/1/25.
//
import SwiftUI

struct CharacterPartItem: View {
    let proxy: GeometryProxy
    let part: CharacterPartType
    let isSelected: Bool
    
    var body: some View {
        Text(part.label)
            .font(isSelected ? .title3BoldResponsive(size: 16, proxy: proxy)
                  : .title3RegularResponsive(size: 16, proxy: proxy))
            .padding(.vertical, 8.scaled)
            .padding(.horizontal, 32.scaled)
            .background(
                isSelected ? Color.primaryGreen : Color.gray04
            )
            .cornerRadius(50)
            .foregroundColor(isSelected ? .white : .gray09)
            
    }
}

#Preview {
    GeometryReader { proxy in
        CharacterPartItem(proxy: proxy, part: .hair, isSelected: true)
    }
}
