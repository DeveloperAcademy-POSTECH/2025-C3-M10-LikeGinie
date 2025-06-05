//
//  CharacterToolbarView.swift
//  PadoStudio
//
//  Created by 윤민경 on 6/4/25.
//

import SwiftUI

struct CharacterToolbarView: View {
    var body: some View {
        HStack {
            // 왼쪽 버튼을 고정 프레임으로 감싸기
            HStack {
                Button(action: {
                    // 뒤로가기 동작
                }) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 80, height: 80)
                        .overlay(
                            Image(systemName: "chevron.left")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Color(red: 0.13, green: 0.72, blue: 0.75))
                        )
                }
            }
            .frame(width: 140) // ← 좌측 고정 폭

            Spacer()

            Text("캐릭터 확인")
                .font(.styledRegular(size: 40))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            Spacer()

            // 오른쪽도 동일한 폭의 빈 프레임
            Color.clear
                .frame(width: 120, height: 80)
        }
        .frame(height: 80)
    }
}

#Preview {
    CharacterToolbarView()
}
