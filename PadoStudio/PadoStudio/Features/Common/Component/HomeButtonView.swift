//
//  HomeButtonView.swift
//  PadoStudio
//
//  Created by gabi on 6/11/25.
//

import SwiftUI

struct HomeButtonView: View {
    @EnvironmentObject var navModel: NavigationViewModel
    let proxy: GeometryProxy
    let buttonSize: (width: CGFloat, font: CGFloat, fheight: CGFloat, padding: CGFloat) = {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return (width: 80, font: 30, fheight: 80, padding: 40)
        default:
            return (width: 44, font: 20, fheight: 60, padding: 16)
        }
    }()

    var body: some View {
        HStack {
            Button {
                print("홈으로")
                navModel.navigateToRoot()
            } label: {
                Circle()
                    .fill(Color.white)
                    .frame(width: buttonSize.width, height: buttonSize.width)
                    .overlay(
                        Image(systemName: "house")
                            .foregroundColor(.primaryGreen)
                            .font(.eliceBold(size: buttonSize.font))
                    )
            }
            Spacer()
        }
        .padding(.horizontal, buttonSize.padding)
        .frame(height: buttonSize.fheight)
    }
}

#Preview {
    GeometryReader { proxy in
        HomeButtonView(proxy: proxy)
    }
}
