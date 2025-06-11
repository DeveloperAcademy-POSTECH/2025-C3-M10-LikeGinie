//
//  HomeButtonView.swift
//  PadoStudio
//
//  Created by gabi on 6/11/25.
//

import SwiftUI

struct HomeButtonView: View {
    @EnvironmentObject var navModel: NavigationViewModel
    
    var body: some View {
        Button {
            print("홈으로")
            navModel.navigate(to: .home)
        } label: {
            Circle()
                .fill(Color.white)
                .frame(width: 80, height: 80)
                .overlay(
                    Image(systemName: "house")
                        .foregroundColor(.primaryGreen)
                        .font(.eliceBold(size: 30))
                    )
        }
    }
}

#Preview {
    HomeButtonView()
}
