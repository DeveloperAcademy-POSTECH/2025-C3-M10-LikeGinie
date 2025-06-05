//
//  CharacterCountSelectView.swift
//  PadoStudioSample
//
//  Created by kim yijun on 5/28/25.
//

import SwiftUI

struct CharacterCountSelectView: View {
    @EnvironmentObject var navModel: NavigationViewModel
    @State private var number = 0
    
    var body: some View {
        ZStack {
            Image("background2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                ToolbarView(title: "인원 선택하기", titleColor: .black)
                
                Spacer() // 상단 여백
                Spacer() // 상단 여백
                
                VStack(spacing: 4) {
                    Text("몇 명의 캐릭터를 만들까요?")
                        .font(.eliceBold(size: 35))
                        .multilineTextAlignment(.center)
                    
                    Text("최대 6명까지 가능해요!")
                        .font(.styledRegular(size: 20))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                
                HStack(spacing: 50) {
                    // 마이너스 버튼
                    Button(action: { number -= 1 }) {
                        ZStack {
                            Circle()
                                .stroke(number > 0 ? Color.primaryGreen : Color.gray04, lineWidth: 8)
                                .foregroundColor(.gray01)
                                .frame(width: 40, height: 40)
                            Image(systemName: "minus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(number > 0 ? Color.primaryGreen : Color.gray04)
                        }
                    }
                    .disabled(number <= 0)
                    
                    Text("\(number)")
                        .font(.eliceBold(size: 100))
                        .frame(minWidth: 60)
                    
                    // 플러스 버튼
                    Button(action: { number += 1 }) {
                        ZStack {
                            Circle()
                                .stroke(number < 6 ? Color.primaryGreen : Color.gray04, lineWidth: 8)
                                .foregroundColor(.gray01)
                                .frame(width: 40, height: 40)
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(number < 6 ? Color.primaryGreen : Color.gray04)
                        }
                    }
                    .disabled(number >= 6)
                }
                
                Spacer()
                
                CharacterSelectbuttonView()
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {}) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.primaryGreen)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("캐릭터 만들기")
                        .font(.eliceBold(size: 22))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("다음") {
                        navModel.navigate(to: .characterCreate(number: number))
                    }
                    .font(.eliceBold(size: 18))
                }
            }
        }
    }
}
#Preview {
    CharacterCountSelectView()
}
