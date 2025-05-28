//
//  MainHomeView.swift
//  LikeGinie
//
//  Created by 윤민경 on 5/28/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 100) { // 각 뷰 사이 간격 조절
            MainTextView()
            ContentView()
            MainButtontView()
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
