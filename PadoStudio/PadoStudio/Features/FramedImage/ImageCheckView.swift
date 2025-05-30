//
//  ImageCheckView.swift
//  PadoStudio
//
//  Created by gabi on 5/30/25.
//

import SwiftUI

struct ImageCheckView: View {
    @EnvironmentObject var navModel: NavigationViewModel
    
    var body: some View {
        VStack(spacing: 50) {
            FramedImageTextView()
            FramedImageView()
            HStack(spacing: 50) {
                RoundButton(iconName: "square.and.arrow.up", label: "공유하기", action: {print("공유!")})
                RoundButton(iconName: "house", label: "처음으로", action: {
                        print("홈!")
                        navModel.navigate(to: .home)
                    })
            }
        }
    }
}

#Preview {
    ImageCheckView().environmentObject(NavigationViewModel())
}
