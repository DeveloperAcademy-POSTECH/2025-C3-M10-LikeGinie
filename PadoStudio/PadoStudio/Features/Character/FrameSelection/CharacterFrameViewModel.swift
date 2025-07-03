//
//  CharacterFrameSelectionViewModel.swift
//  PadoStudio
//
//  Created by Oh Seojin on 6/9/25.
//

import SwiftUI
import Dependencies

final class CharacterFrameViewModel: ObservableObject {
    
    @Dependency(\.getCharactersUseCase) var getCharactersUseCase
    
    @Published var selectedFrame: FrameType = .sea
    @Published var showAlert = false
    
    @Published var characterImages: [UIImage] = []
    @Published var composedImage: UIImage?
    
    private var composedImageCache: [FrameType: UIImage] = [:]

    func loadCharacterImages() async {
        do {
            let characters = try await getCharactersUseCase()
            let images = characters.compactMap { UIImage(contentsOfFile: $0.imagePath) }
            await MainActor.run {
                self.characterImages = images
                self.composedImageCache.removeAll()
                print("loadCharacterImages success: \(images.count)")
            }
        } catch {
            print("Failed to load character images: \(error)")
        }
    }
    
    func composeFramedPreview() {
        if let cached = composedImageCache[selectedFrame] {
            self.composedImage = cached
            return
        }

        let size = CGSize(width: 1000.scaled, height: 1000.scaled)
        if let composed = FramePreviewUtil.composeFramedPreviewWithTransparentBase(
            size: size,
            frameImageName: selectedFrame.imgName,
            characterImages: characterImages
        ) {
            DispatchQueue.main.async {
                self.composedImage = composed
                self.composedImageCache[self.selectedFrame] = composed
            }
        }
    }
    
    func saveComposedImageToCache() -> String? {
        guard let image = composedImage else {
            print("No composed image to save.")
            return nil
        }
        do {
            try FrameImageCacheManager.createFrameDirectory()
            let path = try FrameImageCacheManager.save(image: image, named: selectedFrame.rawValue)
            print("Composed image saved at: \(path)")
            return path
        } catch {
            print("Failed to save composed image: \(error)")
            return nil
        }
    }
}
