//
//  MainTextView.swift
//  LikeGinie
//
//  Created by 윤민경 on 5/28/25.
//

import SwiftUI

struct MainTextView: View {
    let proxy: GeometryProxy
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        if sizeClass == .regular {
            HomePadTextLayout(proxy: proxy)
        } else {
            HomePhoneTextLayout(proxy: proxy)
        }
    }
}

// 아이폰용 레이아웃
struct HomePhoneTextLayout: View {
    let proxy: GeometryProxy
    @Environment(\.horizontalSizeClass) var sizeClass  // 추가

    var body: some View {
        let isPad = (sizeClass == .regular) || (proxy.size.width > 700)

        // 아이패드 기준 화면 너비 (약 1024pt)를 기준으로 비율 계산
        let iPadBaseWidth: CGFloat = 1024.0
        let titleFontRatio: CGFloat = 44.0 / iPadBaseWidth
        let subtitleFontRatio: CGFloat = 10.0 / iPadBaseWidth

        HStack(alignment: .center, spacing: isPad ? 24 : 12) {
            Image("ic_home_title")
                .resizable()
                .scaledToFit()
                .frame(width: proxy.size.width * 0.15)

            VStack(alignment: .center) {
                Text("파도 사진관")
                    .font(.largeSinchonTitleResponsive(size: 30, proxy: proxy))
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.7)
                    .multilineTextAlignment(.leading)

                Text("직접 만든 서핑 캐릭터와 함께 사진을 찍어보세요!")
                    .font(.title3RegularResponsive(size: 8, proxy: proxy))
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.7)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 40)
        .padding(.horizontal)
    }
}

// 아이패드용 레이아웃
struct HomePadTextLayout: View {
    let proxy: GeometryProxy
    @Environment(\.horizontalSizeClass) var sizeClass  // 추가

    var body: some View {
        HStack(alignment: .center, spacing: 24) {
            Image("ic_home_title")
                .resizable()
                .scaledToFit()
                .frame(width: proxy.size.width * 0.10)  // 패드에서 더 작게

            VStack(alignment: .center) {
                Text("파도 사진관")
                    .font(
                        .largeSinchonTitleResponsive(size: 30, proxy: proxy)
                    )  // 더 크게
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                Text("직접 만든 서핑 캐릭터와 함께 사진을 찍어보세요!")
                    .font(.title3RegularResponsive(size: 10, proxy: proxy))  // 더 크게
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            .frame(alignment: .center)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 80)  // 패드에서 더 넓게
        .padding(.horizontal, 80)
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
