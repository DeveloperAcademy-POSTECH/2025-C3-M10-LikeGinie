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
            GeometryReader { proxy in
                let width = proxy.size.width
                let height = proxy.size.height

                Image("bg_home")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: max(width, 1), height: max(height, 1))
                    .position(x: width / 2, y: height / 2)

                VStack(spacing: 0) {
                    Spacer().frame(height: height * 0.08)

                    MainTextView(proxy: proxy)
                        .padding(.top, height * 0.04)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color.yellow.opacity(0.2))

                    ContentView()
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, width * 0.08)
                        .padding(.vertical, max(height * 0.03, 1))
                        

                    Spacer()

                    MainButtonView(
                        onCameraTapped: {
                            navModel.navigate(to: .startRecording)
                        },
                        onGalleryTapped: {
                            navModel.navigate(to: .gallery)
                        }
                    )
                    .padding(.bottom, max(height * 0.02, 1))
                    .background(Color.yellow.opacity(0.2))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomeView().environmentObject(NavigationViewModel())
}
