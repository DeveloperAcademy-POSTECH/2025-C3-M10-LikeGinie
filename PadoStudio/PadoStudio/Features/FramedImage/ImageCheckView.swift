//
//  ImageCheckView.swift
//  PadoStudio
//
//  Created by gabi on 5/30/25.

import SwiftUI

struct ImageCheckView: View {
    @EnvironmentObject var navModel: NavigationViewModel
    let identifiableImage: IdentifiableImage

    @State private var isSharing: Bool = false

    var body: some View {
        ZStack {
            Color.lightYellow.ignoresSafeArea()
            
            VStack(spacing: 20.scaled) {
                HStack {
                    HomeButtonView()
                        .padding(.horizontal, 40)
                    Spacer()
                }
                FramedImageTextView()
                FramedImageView(identifiableImage: identifiableImage)
                    .shadow(color: .black.opacity(0.10), radius: 6, x: 0, y: 2)
                
                HStack(spacing: 50.scaled) {
                    RoundButton(iconName: "square.and.arrow.up", label: "공유하기", action: {
                        print("공유!")
                        isSharing = true
                    })
                    .sheet(isPresented: $isSharing) {
                        FramedImageShareView(image: identifiableImage.image)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}


#Preview {
    let sampleImage = IdentifiableImage(image: UIImage(named: "framed") ?? UIImage())
    ImageCheckView(identifiableImage: sampleImage)
        .environmentObject(NavigationViewModel())
}
