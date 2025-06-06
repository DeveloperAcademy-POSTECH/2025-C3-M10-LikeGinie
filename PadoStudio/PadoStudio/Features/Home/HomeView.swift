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
        GeometryReader { proxy in
            ZStack {
                // 배경
                Image("bg_home")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                // 1. MainTextView만을 위한 VStack (위치 독립)
                VStack {
                    Spacer().frame(height: proxy.size.height * 0.15) // MainTextView를 아래로 내리기 위한 여백
                    MainTextView(proxy: proxy)
                    Spacer() // 필요시 추가 여백
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                // 2. InfiniteCarouselView만을 위한 VStack (위치 독립)
                VStack {
                    Spacer().frame(height: 20) // 위 여백을 줄임 (또는 완전히 제거)
                    InfiniteCarouselView(images: ImageDataService.fetchImages())
                        .padding(.bottom, proxy.size.height * 0.04)
                    Spacer().frame(height: 500) // 아래 여백을 늘려 위치를 조정
                }
                .frame(maxWidth: .infinity, alignment: .center)

                
                // 3. MainButtonView만을 위한 VStack (하단 고정)
                VStack {
                    Spacer()
                    MainButtonView(
                        onCameraTapped: { navModel.navigate(to: .startRecording) },
                        onGalleryTapped: { navModel.navigate(to: .gallery) }
                    )
                    .padding(.bottom, proxy.size.height * 0.02)
                }
                .frame(maxWidth: .infinity, alignment: .bottom)
            }
        }
    }
}
#Preview {
    HomeView().environmentObject(NavigationViewModel())
}
