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
            .scaledToFit()
            .frame(width: 550, height: 770)
    }
}


//#Preview {
//    FramedImageView(image: UIImage(named: "framed"))
//}
