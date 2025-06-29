//
//  CharacterCreateView.swift
//  PadoStudio
//
//  Created by eunsong on 5/31/25.
//

import SwiftUI

struct CharacterCreateView: View {
    let number: Int
    @StateObject var viewModel = CharacterViewModel()
    @State private var currentIndex: Int = 0
    @State private var showBackAlert = false
    @EnvironmentObject var navModel: NavigationViewModel

    var body: some View {
        ZStack {
            GeometryReader { proxy in
                let width = proxy.size.width
                let height = proxy.size.height

                Image("bg_character_creation")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: max(width, 1), height: max(height, 1))
                    .position(x: width / 2, y: height / 2)

                VStack {
                    // MARK: Toolbar
                    ToolbarView(title: "캐릭터 만들기", titleColor: .white) {
                        showBackAlert = true
                    }
                    .safeAreaInset(edge: .top) {
                        Color.clear.frame(height: 48)
                    }
                    
                    // MARK: 캐릭터 전환
                    CharacterPreviewPager(
                        number: number, currentIndex: $currentIndex,
                        viewModel: viewModel, proxy: proxy)

                    VStack {
                        // 탭 선택 영역
                        CharacterPartSelector(
                            viewModel: viewModel, proxy: proxy)

                        // 선택 가능한 아이템 그리드
                        CharacterAssetGrid(
                            proxy: proxy,
                            viewModel: viewModel,
                            currentIndex: currentIndex
                        )

                        // 하단 버튼
                        HStack(spacing: 12) {
                            CharacterActionButton(
                                title: "초기화",
                                foreground: .gray09,
                                background: .gray04,
                                font: .title3RegularResponsive(
                                    size: 13, proxy: proxy),
                                width: proxy.size.width * 0.4,
                                height: proxy.size.height * 0.06
                            ) {
                                currentIndex += 1
                                viewModel.resetCharacter()
                            }
                            
                            if currentIndex != number - 1 {
                                CharacterActionButton(
                                    title: "다음",
                                    foreground: .white,
                                    background: .primaryGreen,
                                    font: .title3RegularResponsive(
                                        size: 13, proxy: proxy),
                                    width: proxy.size.width * 0.4,
                                    height: proxy.size.height * 0.06
                                ) {
                                    viewModel.saveAllCharacterSnapshots(
                                        count: number, imageSize: proxy.size
                                    ) {
                                        currentIndex += 1
                                    }
                                }
                                
                            } else {
                                CharacterActionButton(
                                    title: "저장하기",
                                    foreground: .white,
                                    background: .primaryGreen,
                                    font: .title3RegularResponsive(
                                        size: 13, proxy: proxy),
                                    width: proxy.size.width * 0.4,
                                    height: proxy.size.height * 0.06
                                ) {
                                    viewModel.saveAllCharacterSnapshots(
                                        count: number, imageSize: proxy.size
                                    ) {
                                        navModel.path.append(AppRoute.characterCheck)
                                    }
                                }
                            }
                            
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 8)
                    }
                    .padding(.horizontal, proxy.size.width * 0.04)
                    .padding(.bottom, proxy.safeAreaInsets.bottom + 24)
                    .padding(.top, proxy.size.width * 0.04)
                    .background(
                        TopRoundedShadowBackground()
                    )

                }
            }

        }.ignoresSafeArea()
            .onAppear {
                Task {
                    await viewModel.resetCharacterCreationSession()
                    viewModel.initializeDefaultSelections(count: number)
                }
            }
            .alert("캐릭터가 초기화됩니다!", isPresented: $showBackAlert) {
                Button("취소", role: .cancel) { }
                Button("인원 수정하기", role: .destructive) {
                    navModel.path.removeLast()
                }
            } message: {
                Text("이전 화면으로 돌아가면 생성된 캐릭터가 저장되지 않습니다")
            }
    }
}

struct CharacterActionButton: View {
    let title: String
    let foreground: Color
    let background: Color
    let font: Font
    let width: CGFloat
    let height: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(font)
                .foregroundColor(foreground)
                .padding(.vertical, height * 0.25)
                .padding(.horizontal, width * 0.1)
                .frame(minWidth: width, minHeight: height)
                .background(background)
                .cornerRadius(12)
        }
        .clipShape(Capsule())
    }
}

#Preview("CharacterCreateView") {
    CharacterCreateView(number: 3)
}
