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
        ZStack {
            // 중앙 하단 카메라 버튼
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: onCameraTapped) {
                        VStack(spacing: 8) {
                            Image(systemName: "camera")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48, height: 48)
                                .foregroundColor(.white)
                            Text("기록 남기기")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        .frame(width: 140, height: 140)
                        .background(Circle().fill(Color(red: 0.16, green: 0.74, blue: 0.76)))
                        .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 4)
                    }
                    Spacer()
                }
                .padding(.bottom, 40) // 하단 여백
            }
            
            // 오른쪽 하단 갤러리 버튼
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: onGalleryTapped) {
                        VStack(spacing: 8) {
                            Image(systemName: "photo.on.rectangle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                                .foregroundColor(Color(red: 0.16, green: 0.74, blue: 0.76))
                            Text("갤러리")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(red: 0.16, green: 0.74, blue: 0.76))
                        }
                        .frame(width: 100, height: 100)
                        .background(
                            Circle()
                                .fill(Color.white)
                                .overlay(
                                    Circle()
                                        .stroke(Color(red: 0.16, green: 0.74, blue: 0.76), lineWidth: 3)
                                )
                        )
                        .shadow(color: .black.opacity(0.10), radius: 6, x: 0, y: 2)
                    }
                    Spacer()
                }
                .padding(.bottom, 40) // 하단 여백
                .padding(.leading, 600)
            }
        }
    }
}

#Preview {
    MainButtonView(
        onCameraTapped: {},
        onGalleryTapped: {}
    )
}

