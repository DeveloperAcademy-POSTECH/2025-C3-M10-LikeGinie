//
//  ContentView.swift
//  LikeGinie
//
//  Created by 윤민경 on 5/28/25.
//

import SwiftUI

struct ContentView: View {
    // ImageDataService에서 이미지 데이터 가져오기
    private let images = ImageDataService.fetchImages()
    private let timer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect()
    
    // UI 설정값
    private let itemWidth: CGFloat = 200 // 캐릭터 크기 조절
    private let spacing: CGFloat = 16
    private let speed: CGFloat = 2.0 // 이동 속도
    
    @State private var offset: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            let totalWidth = (itemWidth + spacing) * CGFloat(images.count)
            
            HStack(spacing: spacing) {
                // 무한 스크롤을 위해 이미지 2배 복제
                ForEach(0..<images.count * 2, id: \.self) { idx in
                    Image(images[idx % images.count].name) // ImageData 사용
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: itemWidth, height: itemWidth)
                }
            }
            .offset(x: offset)
            .onReceive(timer) { _ in
                offset -= speed
                // 한 사이클 끝나면 위치 리셋
                if abs(offset) >= totalWidth {
                    offset = 0
                }
            }
            .frame(width: geometry.size.width, height: itemWidth)
            .clipped()
        }
    }
}

#Preview {
    ContentView()
}
