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
                    .frame(width: 48.scaled, height: 36.scaled)
                    .foregroundColor(.white)
                Text(LocalizedStringKey("take_photo"))
                    .font(.eliceBold(size: 30.scaled)) // 커스텀 폰트 적용!
                    .foregroundColor(.white)
            }
            .frame(width: 200.scaled, height: 200.scaled)
            .background(
                Circle()
                    .foregroundColor(.primaryGreen))
            .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    CameraButtonView()
}
