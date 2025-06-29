//
//  CharacterFrameSelectionView.swift
//  PadoStudio
//
//  Created by Oh Seojin on 6/9/25.
//

import SwiftUI

struct CharacterFrameSelectionView: View {
    @StateObject var viewModel = CharacterFrameViewModel()

    var body: some View {
        CharacterFrameSelectionBody()
            .environmentObject(viewModel)
    }
}

struct CharacterFrameSelectionBody: View {

    @EnvironmentObject var navModel: NavigationViewModel
    @EnvironmentObject var viewModel: CharacterFrameViewModel

    @ViewBuilder
    private var previewImage: some View {

        Group {
            if let composedImage = viewModel.composedImage {
                Image(uiImage: composedImage)
                    .resizable()
            } else {
                Image(viewModel.selectedFrame.imgName)
                    .resizable()
            }
        }
        .scaledToFit()
        .frame(width: 300.scaled, height: 400.scaled)
    }

    var body: some View {
        GeometryReader { proxy in

            ZStack {
                // 배경 이미지
                Image("background2")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea()

                VStack {
                    // 네비게이션바
                    ToolbarView(title: "프레임 고르기", titleColor: .black)
                        .safeAreaInset(edge: .top) {
                            Color.clear.frame(height: 48)
                        }

                    Spacer()

                    // 프레임 미리보기
                    ZStack {
                        previewImage
                    }
                    .shadow(radius: 5, x: 10, y: 10)

                    Spacer()

                    // 프레임 선택창
                    VStack {
                        // 프레임 버튼 리스트
                        ScrollView(.horizontal, showsIndicators: true) {
                            CharacterFrameButtonList(
                                selectedFrame: viewModel.selectedFrame,
                                onFrameSelected: { selected in
                                    viewModel.selectedFrame = selected
                                    viewModel.composeFramedPreview()
                                }, proxy: proxy
                            )
                        }
                        .padding(
                            .horizontal,
                            0.1 * proxy.size.width
                        )
                        .frame(maxWidth: .infinity, alignment: .center)

                        // 촬영 버튼
                        SquareButton(color: .green, label: "촬영하기") {
                            viewModel.showAlert = true
                        }
                    }
                    .frame(height: ScreenRatioUtility.screenHeight * 0.3)
                    .background(
                        TopRoundedShadowBackground()
                    )

                }
                .ignoresSafeArea(.all)
            }
            .alert("촬영이 시작됩니다!", isPresented: $viewModel.showAlert) {
                Button("취소", role: .cancel) {}
                Button("촬영하기") {
                    if let savedPath = viewModel.saveComposedImageToCache() {
                        navModel.path.append(
                            AppRoute.camera(frameImagePath: savedPath)
                        )
                    }
                }
            } message: {
                Text("캐릭터와 프레임을 수정할 수 없으니 \n다시 확인해 주세요.")
            }
            .onAppear {
                Task {
                    await viewModel.loadCharacterImages()
                    viewModel.composeFramedPreview()
                }
            }
        }
    }
}

#Preview {
    CharacterFrameSelectionView()
        .environmentObject(NavigationViewModel())
        .environmentObject(CharacterFrameViewModel())
}
