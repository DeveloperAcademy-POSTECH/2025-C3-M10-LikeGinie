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
                Image("bg_home")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
            }

            VStack(spacing: 0) {
                Spacer().frame(height: 64)  // increased top margin for title

                MainTextView()
                    .padding(.top, 32.0)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.yellow.opacity(0.2))

                ContentView()
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 24)
                    .background(Color.yellow.opacity(0.2))

                Spacer()

                MainButtonView(
                    onCameraTapped: {
                        navModel.navigate(to: .startRecording)
                    },
                    onGalleryTapped: {
                        navModel.navigate(to: .gallery)
                    }
                )
                .padding(.bottom, 16)
                .background(Color.yellow.opacity(0.2))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

        }.ignoresSafeArea()
    }
}

#Preview {
    HomeView().environmentObject(NavigationViewModel())
}
