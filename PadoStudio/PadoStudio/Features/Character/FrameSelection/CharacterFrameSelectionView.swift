//
//  CharacterFrameSelectionView.swift
//  PadoStudio
//
//  Created by Oh Seojin on 6/9/25.
//

import SwiftUI

struct CharacterFrameSelectionView: View {
    @ObservedObject var viewModel: CharacterViewModel
    let surferCharacters: [CharacterAsset] = []
    
    var body: some View {
        ZStack {
            // 배경 이미지
            Image("background2")
                .resizable()
                .frame(maxWidth: .infinity)
                .ignoresSafeArea()

            VStack {
                // 네비게이션바
                ToolbarView(title: "프레임 고르기", titleColor: .black)
                    .padding(.top, 16)
                
                Spacer()

                // 프레임 미리보기
                ZStack {
                    // 프레임 - 이미지
                    
                    // 캐릭터
                    let previews = CharacterPartType.allCases.map { part in
                        (
                            part,
                            viewModel.getOriginImageName(for: part, index: 1)
                        )
                    }
                    
                    ZStack {
                        Image("origin-standard")
                            .resizable()
                            .scaledToFit()

                        ForEach(previews, id: \.0) { part, name in
                            CharacterPartPreview(part: part, previewName: name)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    HStack {
                        // 캐릭터 리스트 불러오기
                        // 오른쪽 정렬
                    }
                }

                // 프레임 선택창
                VStack {
                    // 프레임 버튼 리스트
                    HStack {

                    }
                    // 촬영 버튼
                    // alert
                }

            }
        }
    }
}

#Preview {
    CharacterFrameSelectionView(viewModel: CharacterViewModel())
}
