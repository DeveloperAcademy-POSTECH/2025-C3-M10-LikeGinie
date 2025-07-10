//
//  CharacterSelectbutton.swift
//  PadoStudio
//
//  Created by 윤민경 on 6/5/25.
//

import SwiftUI

struct CharacterSelectbuttonView: View {
    @Environment(\.horizontalSizeClass) private var sizeClass

    var body: some View {
        if sizeClass == .regular {
            CharacterSelectPadButton()
        } else {
            CharacterSelectPhoneButton()
        }
    }
}

// 아이폰용 버튼
struct CharacterSelectPhoneButton: View {
    var body: some View {
        Button(action: {
            // 버튼 클릭 시 동작
        }) {
            Text(LocalizedStringKey("setting"))
                .font(.eliceBold(size: 25))
                .foregroundColor(.white)
                .frame(width: 160, height: 36)
        }
        .background(Color.primaryGreen)
        .cornerRadius(10)
    }
}

// 아이패드용 버튼 (더 크게, 더 넓게)
struct CharacterSelectPadButton: View {
    var body: some View {
        Button(action: {
            // 버튼 클릭 시 동작
        }) {
            Text(LocalizedStringKey("setting"))
                .font(.eliceBold(size: 25))
                .foregroundColor(.white)
                .frame(width: 372, height: 89)
        }
        .background(Color.primaryGreen)
        .cornerRadius(20)
    }
}

#Preview {
    CharacterSelectbuttonView()
}
