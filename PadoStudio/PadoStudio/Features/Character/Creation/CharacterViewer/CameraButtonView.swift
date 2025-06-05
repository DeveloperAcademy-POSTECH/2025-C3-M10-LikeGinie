//
//  CameraButtonView.swift
//  PadoStudio
//
//  Created by 윤민경 on 6/3/25.
//

import SwiftUI

struct CameraButtonView: View {
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: "camera.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 36)
                    .foregroundColor(.white)
                Text("촬영하기")
                    .font(.eliceBold(size: 30)) // 커스텀 폰트 적용!
                    .foregroundColor(.white)
            }
            .frame(width: 200, height: 200)
            .background(
                Circle()
                    .fill(Color(red: 0.13, green: 0.72, blue: 0.75))
            )
            .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    CameraButtonView()
}
