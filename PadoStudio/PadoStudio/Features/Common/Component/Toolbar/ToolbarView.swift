//
//  ToolbarView.swift
//  PadoStudio
//
//  Created by 윤민경 on 6/5/25.
//

import SwiftUI

enum ToolbarTitleColor {
    case black
    case white
    
    var color: Color {
        switch self {
        case .black:
            return .black
        case .white:
            return .white
        }
    }
}

struct ToolbarView: View {
    let title: String
    let titleColor: ToolbarTitleColor
    
    var body: some View {
        HStack {
            // 버튼 앞에 원하는 만큼의 공간
            Color.clear
                .frame(width: 40) // ← 이 값을 조정해서 공간 크기 변경
            
            // 왼쪽 chevron 버튼
            Button(action: {
                // 뒤로가기 동작
            }) {
                Circle()
                    .fill(Color.white)
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "chevron.left")
                            .foregroundColor(.primaryGreen)
                            .font(.eliceBold(size: 30))
                    )
            }
            .frame(width: 80, height: 80)
            
            Spacer()
            
            // 얇은 서체 적용
            Text(title)
                .font(.styledRegular(size: 32)) // 여기만 변경!
                .foregroundColor(titleColor.color)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            // 오른쪽 공간(버튼과 균형 맞춤)
            Color.clear
                .frame(width: 100) // 버튼+여백 합친 크기만큼
        }
        .frame(height: 80)
    }
}
