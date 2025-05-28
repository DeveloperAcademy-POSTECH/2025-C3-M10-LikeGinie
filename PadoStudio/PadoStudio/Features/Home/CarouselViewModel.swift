//
//  ViewModel.swift
//  LikeGinie
//
//  Created by 윤민경 on 5/28/25.
//

import Combine
import SwiftUI

class CarouselViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var currentIndex: Int = 0
    @Published var images: [ImageData] = []
    
    // MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()
    private let timerInterval: TimeInterval = 3
    
    init() {
        loadImages()
        setupTimer()
    }
    
    // MARK: - Data Loading
    private func loadImages() {
        images = ImageDataService.fetchImages()
    }
    
    // MARK: - Timer Logic
    private func setupTimer() {
        Timer.publish(every: timerInterval, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.moveToNext()
            }
            .store(in: &cancellables)
    }
    
    private func moveToNext() {
        currentIndex = (currentIndex + 1) % images.count
    }
    
    // MARK: - Public Methods
    func getLoopedImages() -> [ImageData] {
        images + images + images
    }
}
