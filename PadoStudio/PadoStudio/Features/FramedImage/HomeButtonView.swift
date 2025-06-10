//
//  HomeButtonView.swift
//  PadoStudio
//
//  Created by gabi on 6/9/25.
//

import SwiftUI

struct HomeButtonView: View {
    @EnvironmentObject var navModel: NavigationViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                print("홈버튼 눌렸다!")
                navModel.navigate(to: .home)
            }) {
                Circle()
                    .fill(Color.white)
                    .frame(width: 80.scaled, height: 80.scaled)
                    .overlay(
                        Image(systemName: "house")
                            .foregroundColor(.primaryGreen)
                            .font(.eliceBold(size: 30))
                    )
            }
            .padding(.horizontal, 43.scaled)
            .padding(.vertical, 20.scaled)
            Spacer()
        }
    }
}

#Preview {
    HomeButtonView()
}
