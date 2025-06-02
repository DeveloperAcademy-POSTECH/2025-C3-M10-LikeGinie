//
//  CharacterCheckView.swift
//  PadoStudio
//
//  Created by 윤민경 on 6/2/25.
//

import SwiftUI

struct CharacterCheckView: View {
    var body: some View {
        VStack(spacing: 32) {
            Image("Asset5")
            Text("완성된 캐릭터를 확인해주세요!")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.black)

            Button(action: {
                // 버튼 클릭 시 동작
            }) {
                VStack(spacing: 12) {
                    Image(systemName: "camera.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 36)
                        .foregroundColor(.white)
                    Text("촬영하기")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                }
                .frame(width: 140, height: 140)
                .background(
                    Circle()
                        .fill(Color(red: 0.13, green: 0.72, blue: 0.75)) // 민트색
                )
                .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

#Preview {
    CharacterCheckView()
}
