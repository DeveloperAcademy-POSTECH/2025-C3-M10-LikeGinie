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
                    // MARK: Toolbar 추가하기

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
                                foreground: .gray01,
                                background: .gray04,
                                font: .title3RegularResponsive(
                                    size: 11.scaled, proxy: proxy),
                                width: proxy.size.width * 0.4,
                                height: 42
                            ) {
                                viewModel.resetCharacter()
                            }

                            CharacterActionButton(
                                title: "저장하기",
                                foreground: .white,
                                background: .primaryGreen,
                                font: .title3RegularResponsive(
                                    size: 11.scaled, proxy: proxy),
                                width: proxy.size.width * 0.4,
                                height: 42
                            ) {
                                viewModel.saveAllCharacterSnapshots(
                                    count: number, imageSize: proxy.size
                                ) {
                                    navModel.path.append(AppRoute.camera)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal, proxy.size.width * 0.04)
                    .padding(.bottom, proxy.size.width * 0.015)
                    .padding(.top, proxy.size.width * 0.04)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .shadow(
                                color: Color.gray05, radius: 10, x: 0, y: -4)
                    )

                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            Task {
                await viewModel.resetCharacterCreationSession()
            }
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
        Button(title, action: action)
            .font(font)
            .foregroundColor(foreground)
            .frame(width: width, height: height)
            .background(background)
            .cornerRadius(20)
            .clipShape(Capsule())
    }
}

#Preview("CharacterCreateView") {
    CharacterCreateView(number: 3)
}
