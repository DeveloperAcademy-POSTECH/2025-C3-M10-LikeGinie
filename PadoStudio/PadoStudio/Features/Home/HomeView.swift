//
//  MainHomeView.swift
//  LikeGinie
//
//  Created by 윤민경 on 5/28/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navModel: NavigationViewModel

    var body: some View {
        VStack(spacing: 100) {  // 각 뷰 사이 간격 조절
            MainTextView()
            ContentView()
            MainButtonView(
                onCameraTapped: {
                    navModel.navigate(to: .startRecording)
                },
                onGalleryTapped: {
                    navModel.navigate(to: .gallery)
                }
            )
        }
        .padding()
    }
}

#Preview {
    HomeView().environmentObject(NavigationViewModel())
}
