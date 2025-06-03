//
//  MainTextView.swift
//  LikeGinie
//
//  Created by 윤민경 on 5/28/25.
//

import SwiftUI

struct MainTextView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Image("ic_home_title")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)

            VStack(alignment: .leading, spacing: 8) {
                Text("파도 사진관")
                    .font(.largeSinchonTitle(size: 32))
                    .foregroundColor(.white)

                Text("직접 만든 서핑 캐릭터와 함께 사진을 찍어보세요!")
                    .font(.title3)
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 40)
        .padding(.horizontal)
    }
}

#Preview {
    ZStack {
        Color.primaryGreen.ignoresSafeArea()
        MainTextView()
    }
}
