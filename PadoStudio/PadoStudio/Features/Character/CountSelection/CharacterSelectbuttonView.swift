//
//  CharacterSelectbutton.swift
//  PadoStudio
//
//  Created by 윤민경 on 6/5/25.
//

import SwiftUI

struct CharacterSelectbuttonView: View {
    var body: some View {
        Button(action: {
            // 버튼 클릭 시 동작
        }) {
            Text("설정하기")
                .font(.eliceBold(size: 25))
                .foregroundColor(.white)
                .frame(width: 372, height: 89) // 가로 크기 고정
        }
        .background(Color.primaryGreen)
        .cornerRadius(12)
    }
}

#Preview {
    CharacterSelectbuttonView()
}
