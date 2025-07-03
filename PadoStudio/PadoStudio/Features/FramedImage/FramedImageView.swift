//
//  FramedImageView.swift
//  PadoStudio
//
//  Created by gabi on 5/30/25.
//

import SwiftUI

struct FramedImageView: View {
    let identifiableImage: IdentifiableImage
    
    var body: some View {
        Image(uiImage: identifiableImage.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(
                width: ScreenRatioUtility.imageWidth,
                height: ScreenRatioUtility.imageHeight
            )
            .clipped()
    }
}


//#Preview {
//    FramedImageView(image: UIImage(named: "framed"))
//}
