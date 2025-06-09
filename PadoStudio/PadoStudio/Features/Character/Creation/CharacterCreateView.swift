//
//  CharacterCreateView.swift
//  PadoStudio
//
//  Created by eunsong on 5/31/25.
//
import SwiftUI

struct CharacterCreateView: View {
    let number: Int
    @EnvironmentObject var viewModel: CharacterViewModel
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
                        // 현재 인덱스의 캐릭터만 초기화
                        viewModel.resetCharacter(at: currentIndex)
                    }
                    .buttonStyle(.bordered)

                    Button("저장하기") {
                        // 저장 처리 - 카메라로 이동
                        print("캐릭터 저장 완료 - 생성된 캐릭터 수: \(viewModel.selections.count)")
                        navModel.path.append(AppRoute.frameSelect)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding(.horizontal, 16)
        }
        .onAppear {
            // 디버깅을 위한 로그
            print("CharacterCreateView - 캐릭터 생성 화면 진입, 인원수: \(number)")
        }
    }
}

#Preview("CharacterCreateView") {
    CharacterCreateView(number: 3)
        .environmentObject(CharacterViewModel())
}
