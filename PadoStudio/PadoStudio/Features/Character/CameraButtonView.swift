//
//  CameraButtonView.swift
//  PadoStudio
//
//  Created by 윤민경 on 6/3/25.
//

import SwiftUI

struct CameraButtonView: View {
    var body: some View {
        VStack {
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

#Preview {
    CameraButtonView()
}
