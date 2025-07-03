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
        GeometryReader { proxy in
            ZStack {
                Color.lightYellow.ignoresSafeArea()

                VStack {

                    HomeButtonView(proxy: proxy)
                        .safeAreaInset(edge: .top) {
                            Color.clear.frame(height: 48.scaled)
                        }

                    Spacer()

                    VStack {
                        FramedImageTextView()
                        FramedImageView(identifiableImage: identifiableImage)
                            .shadow(
                                color: .black.opacity(0.10),
                                radius: 6,
                                x: 0,
                                y: 2
                            )
                            .padding()
                    }
                    Spacer()

                    RoundButton(
                        iconName: "square.and.arrow.up",
                        label: "공유하기",
                        action: {
                            print("공유!")
                            isSharing = true
                        }
                    )
                    .sheet(isPresented: $isSharing) {
                        FramedImageShareView(image: identifiableImage.image)
                    }

                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    let sampleImage = IdentifiableImage(
        image: UIImage(named: "framed") ?? UIImage()
    )
    ImageCheckView(identifiableImage: sampleImage)
        .environmentObject(NavigationViewModel())
}
