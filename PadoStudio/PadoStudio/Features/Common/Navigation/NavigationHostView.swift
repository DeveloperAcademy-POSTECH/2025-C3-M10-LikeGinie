//
//  NavigationHostView.swift
//  PadoStudio
//
//  Created by eunsong on 5/28/25.
//


import SwiftUI

struct NavigationHostView: View {
    @EnvironmentObject var navModel: NavigationViewModel

    var body: some View {
        NavigationStack(path: $navModel.path) {
            HomeView()
                .navigationDestination(for: AppRoute.self) { route in  
                    switch route {
                    case .camera:
                        CameraView()
                    case .gallery:
                        GalleryView()
                    case .home:
                        HomeView()
                    case .result(let identifiableImage):
                        CameraStageView(
                            image: identifiableImage.image,
                            onRetake: {
                                navModel.path.removeLast()
                            }                        )
                    case .ImageCheck(let identifiableImage):
                        ImageCheckView(identifiableImage: identifiableImage)
                    }
                }
        }
    }
}
