//
//  MainTextView.swift
//  LikeGinie
//
//  Created by 윤민경 on 5/28/25.
//

import SwiftUI

struct MainTextView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("파도 사진관")
                .font(.system(size: 80, weight: .bold))
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text("직접 만든 서핑 캐릭터와 함께 사진을 찍어보세요!")
                .foregroundColor(.white)
        }
    }
}

#Preview {
    MainTextView()
}
