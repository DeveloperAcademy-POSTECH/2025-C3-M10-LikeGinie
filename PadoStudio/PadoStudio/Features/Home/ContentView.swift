//
//  ContentView.swift
//  LikeGinie
//
//  Created by 윤민경 on 5/28/25.
//

// ContentView.swift
import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @StateObject private var viewModel = CarouselViewModel()
    private let imageWidth: CGFloat = 200
    private let imageSpacing: CGFloat = 32
    
    var body: some View {
        GeometryReader { geo in
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: imageSpacing) {
                        ForEach(viewModel.getLoopedImages().indices, id: \.self) { idx in
                            Image(viewModel.getLoopedImages()[idx].name)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: imageWidth, height: 300)
                                .clipped()
                                .overlay(
                                    Rectangle()
                                        .stroke(Color.gray, lineWidth: 3)
                                )
                                .id(idx)
                        }
                    }
                }
                .onChange(of: viewModel.currentIndex) {
                    handleScroll(proxy: proxy, geometry: geo)
                }
                .onAppear {
                    initialScrollPosition(proxy: proxy, geometry: geo)
                }
            }
        }
        .frame(height: 300)
    }
    
    // MARK: - Private Methods
    private func initialScrollPosition(proxy: ScrollViewProxy, geometry: GeometryProxy) {
        let startIndex = viewModel.images.count
        proxy.scrollTo(startIndex, anchor: .leading)
    }
    
    private func handleScroll(proxy: ScrollViewProxy, geometry: GeometryProxy) {
        let imagesCount = viewModel.images.count
        let end = imagesCount * 2 - 1
        let nextIndex = viewModel.currentIndex + imagesCount
        
        withAnimation(.easeInOut(duration: 1.5)) {
            proxy.scrollTo(nextIndex, anchor: .leading)
        }
        
        if nextIndex == end {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                withAnimation(.none) {
                    proxy.scrollTo(imagesCount, anchor: .leading)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
