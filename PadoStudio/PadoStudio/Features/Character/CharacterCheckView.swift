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
            Image("캐릭터확인_배경")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 상단 바
                HStack {
                    Button(action: {
                        // 뒤로가기 동작
                    }) {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 80, height: 80)
                            .overlay(
                                Image(systemName: "chevron.left")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color(red: 0.13, green: 0.72, blue: 0.75))
                            )
                    }
                    .padding(.leading, 50)

                    Spacer()

                    Text("캐릭터 확인")
                        .font(.system(size: 40))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)

                    Spacer()

                    Color.clear
                        .frame(width: 80 + 50, height: 80)
                }
                .frame(height: 80)

                // 중앙에 오게 하기 위한 Spacer
                Spacer()

                // 캐릭터와 텍스트 묶음
                VStack(spacing: 2) {
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
