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
            // 배경 이미지
            Image("bg_home")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 30) {
                GeometryReader { proxy in
                    MainTextView(proxy: proxy)
                        .padding(.top, UIScreen.main.bounds.height * 0.04)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .frame(height: 150) // 고정 높이 지정

                InfiniteCarouselView(images: ImageDataService.fetchImages())
                    .padding(.horizontal, 20)
                    .padding(.top, 20)

                Spacer()

                MainButtonView(
                    onCameraTapped: {
                        // 카메라 버튼 눌렀을 때 실행할 코드
                        navModel.navigate(to: .startRecording)
                    },
                    onGalleryTapped: {
                        // 갤러리 버튼 눌렀을 때 실행할 코드
                        navModel.navigate(to: .gallery)
                    }
                )

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
    }
}

#Preview {
    HomeView().environmentObject(NavigationViewModel())
}
