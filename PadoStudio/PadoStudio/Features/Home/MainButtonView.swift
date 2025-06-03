//
//  MainButtonView.swift
//  LikeGinie
//
//  Created by 윤민경 on 5/28/25.
//

import SwiftUI

struct MainButtonView: View {
    let onCameraTapped: () -> Void
    let onGalleryTapped: () -> Void

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let buttonSize = max(width * 0.18, 90)
            let gallerySize = buttonSize * 0.7

            ZStack {
                // 카메라 버튼 중앙 하단
                CameraButton(action: onCameraTapped, size: buttonSize)
                    .position(x: width / 2, y: height - buttonSize / 2 - 32)

                // 갤러리 버튼 오른쪽 하단
                GalleryButton(action: onGalleryTapped, size: gallerySize)
                    .position(
                        x: width - gallerySize / 2 - 32,
                        y: height - gallerySize / 2 - 32)
            }
        }
        .frame(height: 180)
    }
}

private struct CameraButton: View {
    let action: () -> Void
    let size: CGFloat

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: "camera.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size * 0.35)
                    .foregroundColor(.white)
                Text("기록 남기기")
                    .font(.bodyBold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 4)
            }
            .frame(width: size, height: size)
            .padding(size * 0.05)
            .background(
                Circle().fill(Color.primaryGreen)
            )
            .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 4)
        }

    }
}

private struct GalleryButton: View {
    let action: () -> Void
    let size: CGFloat

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: "photo.on.rectangle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size * 0.4)
                    .foregroundColor(Color.primaryGreen)
                Text("갤러리")
                    .font(.caption1Bold)
                    .foregroundColor(Color.primaryGreen)
            }
            .frame(width: size, height: size)
            .background(
                Circle()
                    .fill(Color.white)
                    .overlay(
                        Circle().stroke(
                            Color.primaryGreen,
                            lineWidth: 3)
                    )
            )
            .shadow(color: .black.opacity(0.10), radius: 6, x: 0, y: 2)
        }
    }
}

#Preview {
    MainButtonView(
        onCameraTapped: {},
        onGalleryTapped: {}
    )
}
