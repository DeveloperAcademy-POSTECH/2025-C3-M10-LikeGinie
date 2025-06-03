//
//  ContentView.swift
//  LikeGinie
//
//  Created by 윤민경 on 5/28/25.
//

// ContentView.swift
import SwiftUI
import Combine

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
        self.offset = 0
        self.startTime = Date()
        stop()
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
        let expectedOffset = -CGFloat(elapsed) * speed
        let resetThreshold = contentWidth
        if abs(expectedOffset) >= resetThreshold {
            self.startTime = Date()
            offset = 0
        } else {
            offset = expectedOffset
        }
    }
}

struct ContentView: View {
    let images = ["Asset5", "Asset5", "Asset5", "Asset5", "Asset5", "Asset5"]
    @State private var imageWidth: CGFloat = 200
    @State private var imageSpacing: CGFloat = 16
    private let speed: CGFloat = 180

    @StateObject private var animator = CarouselAnimator(speed: 180)
    @State private var contentWidth: CGFloat = 1

    var body: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width - 64
            let visibleItemCount = floor(totalWidth / 240)
            let totalSpacing = imageSpacing * (visibleItemCount - 1)
            let calculatedWidth = (totalWidth - totalSpacing) / visibleItemCount
            let characterHeight = calculatedWidth * 1.0
            let availableHeight = geometry.size.height
            let verticalPadding = max((availableHeight - characterHeight) / 2, 0)

            VStack {
                Spacer().frame(height: verticalPadding)

                HStack(spacing: imageSpacing) {
                    ForEach(0..<images.count * 2, id: \.self) { idx in
                        Image(images[idx % images.count])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: calculatedWidth, height: characterHeight)
                    }
                }
                .padding(.horizontal, 32)
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear {
                                imageWidth = calculatedWidth
                                contentWidth = (calculatedWidth + imageSpacing) * CGFloat(images.count)
                                animator.start(contentWidth: contentWidth)
                            }
                            .onDisappear {
                                animator.stop()
                            }
                    }
                )
                .offset(x: animator.offset)
                .frame(height: characterHeight)

//                Spacer()
            }
        }
//        .clipped()
    }
}

#Preview {
    ContentView()
}
