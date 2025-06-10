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
                        ToolbarHiddenWrapper(
                            content:
                                CameraView()
                                .environmentObject(characterViewModel)
                                .environmentObject(characterFrameViewModel)
                        )
                    case .gallery:
                        ToolbarHiddenWrapper(
                            content:
                                GalleryView()
                        )

                    case .startRecording:
                        ToolbarHiddenWrapper(
                            content:
                                CharacterCountSelectView()
                                .environmentObject(characterViewModel)
                        )
                    case .characterCreate(let number):
                        ToolbarHiddenWrapper(
                            content:
                                CharacterCreateView(number: number)
                                .environmentObject(characterViewModel)
                        )
                    case .home:
                        ToolbarHiddenWrapper(
                            content:
                                HomeView()
                        )
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
                        ToolbarHiddenWrapper(
                            content:
                                CharacterFrameSelectionView()
                                .environmentObject(characterFrameViewModel)
                                .environmentObject(characterViewModel)
                        )
                    }

                }
        }
        .environmentObject(characterViewModel)
    }
}
