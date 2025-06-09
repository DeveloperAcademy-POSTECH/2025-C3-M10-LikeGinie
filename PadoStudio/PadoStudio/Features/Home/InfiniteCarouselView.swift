//
//  ContentView.swift
//  LikeGinie
//
//  Created by 윤민경 on 5/28/25.
//

import SwiftUI

struct InfiniteCarouselView: View {
    let images: [ImageData]
    @State private var offset: CGFloat = 0
    private let timer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect()
    private let itemWidth: CGFloat = 300
    private let spacing: CGFloat = 10
    private let loopCount: Int = 3
    private let speed: CGFloat = 2.5

    var body: some View {
        GeometryReader { proxy in
            ZStack {
//                // 1. 고정 배경
//                Image("background")
//                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea()

                // 2. 무한 반복 캐릭터
                HStack(spacing: spacing) {
                    ForEach(0..<(images.count * loopCount), id: \.self) { idx in
                        Image(images[idx % images.count].name)
                            .resizable()
                            .scaledToFit()
                            .frame(width: itemWidth, height: itemWidth)
                    }
                }
                .offset(x: offset)
                .onReceive(timer) { _ in
                    offset -= speed
                    let totalWidth = CGFloat(images.count) * (itemWidth + spacing)
                    if abs(offset) >= totalWidth {
                        offset += totalWidth
                    }
                }
                .frame(width: proxy.size.width, height: itemWidth)
                .clipped()
            }
        }
        .frame(height: itemWidth)
    }
}

struct ContentView: View {
    var body: some View {
        InfiniteCarouselView(images: ImageDataService.fetchImages())
    }
}

#Preview {
   ContentView()
}
