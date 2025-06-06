//
//  ContentView.swift
//  LikeGinie
//
//  Created by 윤민경 on 5/28/25.
//

import SwiftUI

struct InfiniteCarouselView: View {
    let images: [ImageData]
    @State private var scrollOffset: CGFloat = 0
    @State private var contentWidth: CGFloat = 1
    private let timer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect()

    private let itemWidth: CGFloat = 200
    private let spacing: CGFloat = 20
    private let loopCount: Int = 5
    private let speed: CGFloat = 2 // ⭐️ 속도 조절용

    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer() // ⭐️ 캐릭터를 아래로 내리기

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5) { // ⭐️ 간격을 좁힌 부분
                        ForEach(0..<images.count * loopCount, id: \.self) { idx in
                            Image(images[idx % images.count].name)
                                .resizable()
                                .scaledToFit()
                                .frame(width: itemWidth, height: itemWidth)
                        }
                    }
                    .background(
                        GeometryReader { geo -> Color in
                            DispatchQueue.main.async {
                                self.contentWidth = geo.size.width
                            }
                            return Color.clear
                        }
                    )
                }
                .content.offset(x: scrollOffset)
                .disabled(true)
                .onAppear {
                    scrollOffset = -contentWidth / 2
                }
                .onReceive(timer) { _ in
                    scrollOffset -= speed

                    if scrollOffset <= -contentWidth {
                        scrollOffset = -contentWidth / 2
                    }
                }
            }
        }
        .frame(height: itemWidth * 1.5) // ⭐️ 여유 높이 확보
    }
}

#Preview {
    InfiniteCarouselView(images: ImageDataService.fetchImages())
}
