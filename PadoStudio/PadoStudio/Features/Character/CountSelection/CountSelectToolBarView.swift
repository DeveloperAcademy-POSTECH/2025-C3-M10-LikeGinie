//
//  CountSelectToolBarView.swift
//  PadoStudio
//
//  Created by 윤민경 on 6/5/25.
//

import SwiftUI

struct CountSelectToolBarView: View {
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
                                .frame(width: 30, height: 30)
                                .foregroundColor(.primaryGreen)
                                .font(.eliceBold(size: 30)) // 커스텀 폰트 메서드 적용
                        )
                }
            }
            .frame(width: 180, height: 80) // ← 좌측 고정 폭

            Spacer()

            Text("인원 선택하기")
                .font(.styledRegular(size: 40))
                .foregroundColor(.black)
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
    CountSelectToolBarView()
}
