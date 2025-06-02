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
//                        Text("카메라 뷰 준비 중")
                    case .gallery:
                        GalleryView()
                    case .home:
                        HomeView()
                    }
                }
        }
    }
}
