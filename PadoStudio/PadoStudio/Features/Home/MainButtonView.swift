//
//  MainButtonView.swift
//  LikeGinie
//
//  Created by 윤민경 on 5/28/25.
//

import SwiftUI

struct CircleIconButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: 100, height: 100)
                .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
            configuration.label
                .foregroundColor(configuration.isPressed ? .gray : .black)
        }
    }
}

struct CircleButton: View {
    let systemName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
        }
        .buttonStyle(CircleIconButtonStyle())
    }
}

struct MainButtonView: View {
    @EnvironmentObject var navModel: NavigationViewModel

    var body: some View {
        HStack(spacing: 80) {
            VStack(spacing: 25) {
                CircleButton(systemName: "camera.fill") {
                    print("촬영하기 버튼 눌림")
                    navModel.navigate(to: .camera)
                }
                Text("촬영하기")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.black)
            }
            VStack(spacing: 25) {
                CircleButton(systemName: "photo.on.rectangle") {
                    print("갤러리 버튼 눌림")
                    navModel.navigate(to: .gallery)
                }
                Text("갤러리")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.black)
            }
        }
        .padding()
    }
}

#Preview {
    MainButtonView().environmentObject(NavigationViewModel())
}
