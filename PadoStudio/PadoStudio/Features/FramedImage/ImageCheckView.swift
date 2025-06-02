//
//  ImageCheckView.swift
//  PadoStudio
//
//  Created by gabi on 5/30/25.
//

import SwiftUI

struct ImageCheckView: View {
    @EnvironmentObject var navModel: NavigationViewModel
    @State private var isSharing: Bool = false
    @State private var sharedImage = UIImage(named: "framed")
    
    var body: some View {
        VStack(spacing: 50) {
            FramedImageTextView()
            FramedImageView(image: sharedImage)
            HStack(spacing: 50) {
                RoundButton(iconName: "square.and.arrow.up", label: "공유하기", action: {
                    print("공유!")
                    isSharing = true
                })
                .sheet(isPresented: $isSharing) {
                    if let image = sharedImage {
                        FramedImageShareView(image: image)
                    } else {
                        Text("이미지를 불러올 수 없습니다.")
                    }
                }
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
