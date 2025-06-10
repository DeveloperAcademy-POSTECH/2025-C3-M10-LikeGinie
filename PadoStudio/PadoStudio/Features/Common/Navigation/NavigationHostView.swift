//
//  NavigationHostView.swift
//  PadoStudio
//
//  Created by eunsong on 5/28/25.
//


import SwiftUI

struct NavigationHostView: View {
    @EnvironmentObject var navModel: NavigationViewModel
    @StateObject private var characterViewModel = CharacterViewModel()
    @StateObject private var characterFrameViewModel = CharacterFrameViewModel()

    var body: some View {
        NavigationStack(path: $navModel.path) {
            HomeView()
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .camera:
                        CameraView()
                            .environmentObject(characterViewModel)
                            .environmentObject(characterFrameViewModel)
                    case .gallery:
                        GalleryView()
                    case .startRecording:
                        CharacterCountSelectView()
                            .environmentObject(characterViewModel)
                    case .characterCreate(let number):
                        CharacterCreateView(number: number)
                            .environmentObject(characterViewModel)
                    case .home:
                        HomeView()
                    case .result(let identifiableImage):
                        CameraStageView(
                            image: identifiableImage.image,
                            onRetake: {
                                navModel.path.removeLast()
                            }
                        )
                        .environmentObject(characterViewModel)
                    case .ImageCheck(let identifiableImage):
                        ImageCheckView(identifiableImage: identifiableImage)
                    case .frameSelect:
                        CharacterFrameSelectionView()
                            .environmentObject(characterFrameViewModel)
                            .environmentObject(characterViewModel)
                    }
                    
                }
        }
        .environmentObject(characterViewModel)
    }
}
