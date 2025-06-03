//
//  CameraButtonView.swift
//  PadoStudio
//
//  Created by 윤민경 on 6/3/25.
//

import SwiftUI

struct CameraButtonView: View {
    var action: () -> Void = {} // 외부에서 버튼 동작을 전달받음

    var body: some View {
        Button(action: action) {
            VStack() {
                Image(systemName: "camera.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 36)
                    .foregroundColor(.white)
                Text("촬영하기")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(.white)
            }
            .frame(width: 200, height: 200)
            .background(
                Circle()
                .fill(Color(red: 0.13, green: 0.72, blue: 0.75)) // 민트색
            )
            .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
        }
        .buttonStyle(PlainButtonStyle())
//          필요하다면 아래 코드로 배경을 추가하세요
//         .frame(maxWidth: .infinity, maxHeight: .infinity)
//         .background(Color.white)
    }
}

#Preview {
    CameraButtonView()
}
