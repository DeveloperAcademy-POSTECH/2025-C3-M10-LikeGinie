//
//  CharacterCheckView.swift
//  PadoStudio
//
//  Created by 윤민경 on 6/2/25.
//
import SwiftUI

struct CharacterCheckView: View {
    @State private var showAlert = false
    @EnvironmentObject var navModel: NavigationViewModel
    @EnvironmentObject var viewModel: CharacterFrameViewModel

    let size = CGSize(width: 1000, height: 1000)

    var body: some View {
        ZStack {
            // 전체 배경 이미지
            Image("background1 1")
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 중앙에 오게 하기 위한 Spacer
                ToolbarView(title: "캐릭터 확인", titleColor: .white)
                    .safeAreaInset(edge: .top) {
                        Color.clear.frame(height: 48)
                    }

                Spacer()

                // 캐릭터와 텍스트 묶음
                VStack(spacing: 2) {
                    
                    Spacer().frame(height: 160) // SurferCharacterView 위에 여백
                    if viewModel.characterImages.count > 6 {
                        ScrollView(.horizontal){
                            SurferCharacterView()

                        }
                    } else {
                        SurferCharacterView()

                    }
                    CharacterTextView()
                }

                // 아래쪽 Spacer
                Spacer()

                // 하단 버튼
                SquareButton(color: .green, label: "확인", action: {
                    if viewModel.saveComposedImageToCache() != nil {
                        navModel.path.append(
                            AppRoute.frameSelect)
                    }
                })
                    .padding(.bottom, 60.scaled)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    CharacterCheckView()
        .environmentObject(NavigationViewModel())
        .environmentObject(CharacterFrameViewModel())
}
