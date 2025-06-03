//
//  CharacterCheckView.swift
//  PadoStudio
//
//  Created by 윤민경 on 6/2/25.
//
import SwiftUI

struct CharacterCheckView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(maxHeight: .infinity) // 상단 Spacer
            VStack(spacing: 10) {
                SurferCharacterView()
                CharacterTextView()
            }
            Spacer()
                .frame(height: 60) // 하단 Spacer의 높이 조절
            CameraButtonView()
                .padding(.bottom, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    CharacterCheckView()
}
