//
//  MainHomeView.swift
//  LikeGinie
//
//  Created by 윤민경 on 5/28/25.
//
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navModel: NavigationViewModel

    var body: some View {
        ZStack {
            // 1. 배경 이미지 (맨 아래)
            Image("홈화면_배경")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // 2. 콘텐츠 (텍스트, 캐릭터, 버튼 등)
            VStack(spacing: 100) {
                MainTextView()
                ContentView()
                MainButtonView()
            }
            .padding(.top, 220) // 이 값을 조절해서 원하는 만큼 내리세요!
            .padding()

        }
    }
}

#Preview {
    HomeView().environmentObject(NavigationViewModel())
}
