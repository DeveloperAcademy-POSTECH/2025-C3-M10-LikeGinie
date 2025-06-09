//
//  CharacterCheckView.swift
//  PadoStudio
//
//  Created by 윤민경 on 6/2/25.
//
import SwiftUI

struct CharacterCheckView: View {
    @State private var showAlert = false

    var body: some View {
        ZStack {
            // 전체 배경 이미지
            Image("background1 1")
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 중앙에 오게 하기 위한 Spacer
                ToolbarView(title: "캐릭터 확인", titleColor: .white)
                
                Spacer()

                // 캐릭터와 텍스트 묶음
                VStack(spacing: 2) {
                    
                    Spacer().frame(height: 160) // SurferCharacterView 위에 여백
                    
                    SurferCharacterView()
                    CharacterTextView()
                }

                // 아래쪽 Spacer
                Spacer()

                // 하단 버튼
                PadoStudio.CameraButtonView {
                    showAlert = true
                }
                .padding(.bottom, 50)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .alert("저장하면 수정이 어려워요!",
               isPresented: $showAlert) {
            Button("촬영하기", role: .cancel) { }
            Button("취소", role: .destructive) { }
        } message: {
            Text("저장하면 캐릭터를 수정할 수 없으니 다시 확인해 주세요.")
        }
    }
}

#Preview {
    CharacterCheckView()
}
