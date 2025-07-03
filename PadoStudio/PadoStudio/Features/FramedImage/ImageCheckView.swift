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
            
            VStack {
                HStack {
                    HomeButtonView()
                        .padding(.horizontal, 40.scaled)
                    Spacer()
                }
                .padding(.top, 20.scaled)
                
                FramedImageTextView()
                FramedImageView(identifiableImage: identifiableImage)
                    .shadow(color: .black.opacity(0.10.scaled), radius: 6.scaled, x: 0.scaled, y: 2.scaled)
                    .padding()
                
                RoundButton(iconName: "square.and.arrow.up", label: "공유하기", action: {
                    print("공유!")
                    isSharing = true
                })
                .sheet(isPresented: $isSharing) {
                    FramedImageShareView(image: identifiableImage.image)
                }
                
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .frame(maxWidth: .infinity.scaled, maxHeight: .infinity.scaled)
        
    }
}


#Preview {
    let sampleImage = IdentifiableImage(image: UIImage(named: "framed") ?? UIImage())
    ImageCheckView(identifiableImage: sampleImage)
        .environmentObject(NavigationViewModel())
}
