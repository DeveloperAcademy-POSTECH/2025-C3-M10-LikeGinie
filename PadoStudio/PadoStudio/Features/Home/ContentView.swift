//
//  ContentView.swift
//  LikeGinie
//
//  Created by 윤민경 on 5/28/25.
//

import Combine
import SwiftUI

class CarouselAnimator: NSObject, ObservableObject {
    @Published var offset: CGFloat = 0
    private var displayLink: CADisplayLink?
    private var startTime: Date?
    private var contentWidth: CGFloat = 1
    private let speed: CGFloat
    
    init(speed: CGFloat) {
        self.speed = speed
        super.init()
    }
    
    func start(contentWidth: CGFloat) {
        self.contentWidth = contentWidth
        self.stop() // Ensure any previous animation is stopped
        self.startTime = Date().addingTimeInterval(Double(offset / speed))
        displayLink = CADisplayLink(target: self, selector: #selector(step))
        displayLink?.add(to: .main, forMode: .common)
    }
    
    func stop() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc private func step() {
        guard let startTime else { return }

        let elapsed = Date().timeIntervalSince(startTime)
        var newOffset = -CGFloat(elapsed) * speed

        let resetThreshold = contentWidth
        if abs(newOffset) >= resetThreshold {
            newOffset = -((abs(newOffset)).truncatingRemainder(dividingBy: resetThreshold))
        }

        offset = newOffset
    }
}

struct ContentView: View {
    let images = ["sample_character_01", "sample_character_02", "sample_character_03", "sample_character_04", "sample_character_05", "sample_character_06"]
    @State private var imageWidth: CGFloat = 200
    @State private var imageSpacing: CGFloat = 8
    private let speed: CGFloat = 180

    @StateObject private var animator = CarouselAnimator(speed: 180)
    @State private var contentWidth: CGFloat = 1

    // 👉 divisor를 외부에서 받도록 추가
    var divisor: CGFloat = 160

    var body: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width - 16 * 2
            let visibleItemCount = floor(totalWidth / divisor) // divisor 사용
            let totalSpacing = imageSpacing * (visibleItemCount - 1)
            let calculatedWidth = (totalWidth - totalSpacing) / visibleItemCount
            let characterHeight = calculatedWidth * 1.0
            let availableHeight = geometry.size.height
            let verticalPadding = max((availableHeight - characterHeight) / 2, 0)

            VStack {
                Spacer().frame(height: verticalPadding)

                HStack(spacing: imageSpacing) {
                    ForEach(0..<images.count * 3, id: \.self) { idx in
                        Image(images[idx % images.count])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: max(calculatedWidth, 1), height: max(characterHeight, 1))
                    }
                }
                .padding(.horizontal, 16)
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear {
                                imageWidth = calculatedWidth
                                contentWidth = (calculatedWidth + imageSpacing) * CGFloat(images.count * 3)
                                animator.start(contentWidth: contentWidth)
                            }
                            .onDisappear {
                                animator.stop()
                            }
                    }
                )
                .offset(x: animator.offset)
                .animation(nil, value: animator.offset)
                .frame(height: max(characterHeight, 1))
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                contentWidth = ((UIScreen.main.bounds.width - 32) / 3 + imageSpacing) * CGFloat(images.count * 3)
                animator.start(contentWidth: contentWidth)
            }
        }
    }
}

#Preview {
    ContentView()
}
