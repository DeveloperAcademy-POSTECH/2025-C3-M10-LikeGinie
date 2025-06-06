//
//  MainTextView.swift
//  LikeGinie
//
//  Created by 윤민경 on 5/28/25.
//

import SwiftUI

struct MainTextView: View {
        let proxy: GeometryProxy

    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            Image("ic_home_title")
                .resizable()
                .scaledToFit()
                .frame(
                    width: proxy.size.width * 0.15
                )

            VStack(alignment: .center) {
                Text("파도 사진관")
                    .font(
                    .largeSinchonTitleResponsive(size: 20, proxy: proxy)
                    )
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                Text("직접 만든 서핑 캐릭터와 함께 사진을 찍어보세요!")
                    .font(.title3RegularResponsive(size: 8, proxy: proxy))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            .frame(alignment: .center)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 40)
        .padding(.horizontal)

    }
}

#Preview {
    GeometryReader { proxy in
        ZStack {
            Color.primaryGreen.ignoresSafeArea()
            MainTextView(proxy: proxy)
        }
    }
}
