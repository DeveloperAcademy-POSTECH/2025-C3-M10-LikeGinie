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
    @State private var showMinAlert = false
    @State private var showMaxAlert = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("몇 명의 캐릭터를 만들까요?")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 4)
            
            Text("최대 6명까지 가능해요!")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 30)
            
            HStack(spacing: 30) {
                Button(action: {
                    if number > 0 {
                        number -= 1
                    } else {
                        showMinAlert = true
                    }
                }) {
                    Image(systemName: "minus.circle")
                        .font(.system(size: 40))
                        .background(
                            Circle()
                                .fill(.white)
                                .shadow(radius: 2)
                        )
                }
                .alert(isPresented: $showMinAlert) {
                    Alert(
                        title: Text("알림"),
                        message: Text("최소 한 명 이상의 캐릭터가 있어야 해요!"),
                        dismissButton: .default(Text("확인"))
                    )
                }
                
                Text("\(number)")
                    .font(.system(size: 50, weight: .bold))
                    .frame(minWidth: 60)
                
                Button(action: {
                    if number < 6 {
                        number += 1
                    } else {
                        showMaxAlert = true
                    }
                }) {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 40))
                        .background(
                            Circle()
                                .fill(.white)
                                .shadow(radius: 2)
                        )
                }
                .alert(isPresented: $showMaxAlert) {
                    Alert(
                        title: Text("알림"),
                        message: Text("최대 6명의 캐릭터만 설정할 수 있어요!"),
                        dismissButton: .default(Text("확인"))
                    )
                }
            }
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button(action: {
//                    
//                }) {
//                    Image(systemName: "chevron.left")
//                }
//            }
            
            ToolbarItem(placement: .principal) {
                Text("캐릭터 만들기")
                    .fontWeight(.semibold)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("다음") {
                    navModel.navigate(to: .characterCreate(number: number))
                }
            }
        }
    }
}

#Preview {
    CharacterCountSelectView()
}
