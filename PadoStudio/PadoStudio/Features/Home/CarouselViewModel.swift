//
//  ViewModel.swift
//  LikeGinie
//
//  Created by 윤민경 on 5/28/25.
//

import Combine
import SwiftUI

struct CarouselImage: Identifiable {
    let id = UUID()
    let name: String
}

class CarouselViewModel: ObservableObject {
    // 원본 이미지 배열
    private let originalImages: [CarouselImage] = [
        CarouselImage(name: "home1"),
        CarouselImage(name: "home2"),
        CarouselImage(name: "home3"),
        CarouselImage(name: "home4"),
        CarouselImage(name: "home5"),
        CarouselImage(name: "home6"),
        // 여기에 이미지 이름 추가
    ]

    // 이미지 배열을 앞뒤로 복제해서 무한 루프처럼 보이게 함
    var loopedImages: [CarouselImage] {
        originalImages + originalImages + originalImages
    }

    @Published var offset: CGFloat = 0
    private var timer: AnyCancellable?

    // 외부에서 설정 가능한 width로 변경
    var singleItemWidth: CGFloat = 1 {
        didSet {
            offset = initialOffset
        }
    }

    var initialOffset: CGFloat {
        -CGFloat(originalImages.count) * singleItemWidth
    }

    init() {}

    func getLoopedImages() -> [CarouselImage] {
        loopedImages
    }

    func autoScroll() {
        timer = Timer.publish(every: 0.016, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.offset -= 1.0  // 스크롤 속도 조절

                // 한 사이클 끝나면 오프셋을 원위치로 순간 이동 (seamless)
                let maxOffset =
                    -CGFloat(originalImages.count * 2) * singleItemWidth
                if self.offset <= maxOffset {
                    self.offset = initialOffset
                }
            }
    }

    deinit {
        timer?.cancel()
    }
}
