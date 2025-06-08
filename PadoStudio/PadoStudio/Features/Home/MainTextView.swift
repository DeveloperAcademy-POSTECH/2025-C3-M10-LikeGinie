//
//  MainTextView.swift
//  LikeGinie
//
//  Created by 윤민경 on 5/28/25.
//

import SwiftUI

struct MainTextView: View {
    let proxy: GeometryProxy
    @Environment(\.horizontalSizeClass) private var sizeClass

    var body: some View {
        let isPad = (sizeClass == .regular) || (proxy.size.width > 700)
        
        // 아이패드 기준 화면 너비 (약 1024pt)를 기준으로 비율 계산
        let iPadBaseWidth: CGFloat = 1024.0
        let titleFontRatio: CGFloat = 44.0 / iPadBaseWidth
        let subtitleFontRatio: CGFloat = 10.0 / iPadBaseWidth
        
        // 폰트 크기 계산 (아이패드/아이폰 분기)
        let titleFontSize: CGFloat = isPad ?
            proxy.size.width * titleFontRatio :
            proxy.size.width * (titleFontRatio * 1.2)

        let subtitleFontSize: CGFloat = isPad ?
            proxy.size.width * subtitleFontRatio :
            proxy.size.width * (subtitleFontRatio * 1.3)
        
        HStack(alignment: .center, spacing: isPad ? 24 : 12) {
            Image("ic_home_title")
                .resizable()
                .scaledToFit()
                .frame(width: min(max(proxy.size.width * (isPad ? 0.10 : 0.18), 60), isPad ? 120 : 80))
                .clipped()
            
            VStack(alignment: .center, spacing: isPad ? 12 : 6) {
                Text("파도 사진관")
                    .minimumScaleFactor(0.5) // 폰트 크기 유동적 조절
                    .font(.largeSinchonTitleResponsive(size: 20, proxy: proxy))
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
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal, isPad ? 80 : 20)
        .padding(.top, isPad ? 60 : 40)
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
