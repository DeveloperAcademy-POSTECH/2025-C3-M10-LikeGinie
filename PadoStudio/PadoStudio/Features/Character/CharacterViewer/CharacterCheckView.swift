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
        GeometryReader { proxy in

            ZStack {
                // 전체 배경 이미지
                Image("background1 1")
                    .resizable()
                    .ignoresSafeArea()

                VStack(spacing: 0.scaled) {
                    // 중앙에 오게 하기 위한 Spacer
                    ToolbarView(title: "character_check_title", titleColor: .white)
                        .safeAreaInset(edge: .top) {
                            Color.clear.frame(height: 48.scaled)
                        }

                    Spacer()

                    // 캐릭터와 텍스트 묶음
                    VStack(spacing: 2.scaled) {

                        Spacer().frame(height: 160.scaled)  // SurferCharacterView 위에 여백
                        if viewModel.characterImages.count > 6 {
                            ScrollView(.horizontal) {
                                SurferCharacterView(proxy: proxy)
                            }
                        } else {
                            SurferCharacterView(proxy: proxy)
                        }
                        CharacterTextView(proxy: proxy)
                    }

                    // 아래쪽 Spacer
                    Spacer()

                    // 하단 버튼
                    SquareButton(
                        color: .green,
                        label: "confirm_button_label",
                        action: {
                            if viewModel.saveComposedImageToCache() != nil {
                                navModel.path.append(
                                    AppRoute.frameSelect
                                )
                            }
                        }
                    )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }

        }
        .ignoresSafeArea()

    }
}

#Preview {
    CharacterCheckView()
        .environmentObject(NavigationViewModel())
        .environmentObject(CharacterFrameViewModel())
}
