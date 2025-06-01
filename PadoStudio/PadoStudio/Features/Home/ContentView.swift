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
    private let imageWidth: CGFloat = 200
    private let imageSpacing: CGFloat = 32
    private let speed: CGFloat = 180

    @StateObject private var animator = CarouselAnimator(speed: 180)
    @State private var contentWidth: CGFloat = 1

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: imageSpacing) {
                ForEach(0..<images.count * 2, id: \.self) { idx in
                    Image(images[idx % images.count])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imageWidth, height: 300)
                }
            }
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            contentWidth = (imageWidth + imageSpacing) * CGFloat(images.count)
                            animator.start(contentWidth: contentWidth)
                        }
                        .onDisappear {
                            animator.stop()
                        }
                }
            )
            .offset(x: animator.offset)
        }
        .frame(height: 300)
        .clipped()
    }
}

#Preview {
    ContentView()
}
