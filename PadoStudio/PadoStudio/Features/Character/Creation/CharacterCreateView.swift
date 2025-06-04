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
        VStack {
            CharacterPreviewPager(
                number: number, currentIndex: $currentIndex,
                viewModel: viewModel)

            VStack {
                // 탭 선택 영역
                CharacterPartSelector(viewModel: viewModel)

                // 선택 가능한 아이템 그리드
                CharacterAssetGrid(
                    viewModel: viewModel,
                    currentIndex: currentIndex
                )

                // 하단 버튼
                HStack(spacing: 12) {
                    Button("초기화") {
                        // 초기화 처리
                    }
                    .buttonStyle(.bordered)

                    Button("저장하기") {
                        navModel.path.append(AppRoute.camera)
                    }
                    .buttonStyle(.borderedProminent)
                }
//                .padding(.bottom, 20)
            }
            .padding(.horizontal, 16)
            //                .padding(.top, 24)

        }
        //        .padding()
    }
}

#Preview("CharacterCreateView") {
    CharacterCreateView(number: 3)
}
