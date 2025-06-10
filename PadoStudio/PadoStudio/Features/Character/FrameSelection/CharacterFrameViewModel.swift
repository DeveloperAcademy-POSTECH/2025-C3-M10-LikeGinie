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
    
    @Published var selectedFrame: Frame = .sea
    @Published var showAlert = false
    
    @Published var characterImages: [UIImage] = []
    @Published var composedImage: UIImage?
    
    private var composedImageCache: [Frame: UIImage] = [:]

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

        let size = CGSize(width: 1000, height: 1000)
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
    
    
    enum Frame: CaseIterable, Hashable {
        case sea, sunset, comic, white, black

        var imgName: String {
            switch self {
            case .sea: return "frame_sea"
            case .sunset: return "frame_sunset"
            case .comic: return "frame_comic"
            case .white: return "frame_white"
            case .black: return "frame_black"
            }
        }

        var btnImgName: String {
            switch self {
            case .sea: return "frame_btn_sea"
            case .sunset: return "frame_btn_sunset"
            case .comic: return "frame_btn_comic"
            case .white: return "frame_btn_white"
            case .black: return "frame_btn_black"
            }
        }
    }
}
