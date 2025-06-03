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
                    number -= 1
                }) {
                    Image(systemName: "minus.circle")
                        .font(.system(size: 40))
                        .background(
                            Circle()
                                .fill(.white)
                                .shadow(radius: 2)
                        )
                }
                .disabled(number <= 0)
                .opacity(number <= 0 ? 0.3 : 1.0)

                Text("\(number)")
                    .font(.system(size: 50, weight: .bold))
                    .frame(minWidth: 60)

                Button(action: {
                    number += 1
                }) {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 40))
                        .background(
                            Circle()
                                .fill(.white)
                                .shadow(radius: 2)
                        )
                }
                .disabled(number >= 6)
                .opacity(number >= 6 ? 0.3 : 1.0)
            }

            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {

                }) {
                    Image(systemName: "chevron.left")
                }
            }

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
