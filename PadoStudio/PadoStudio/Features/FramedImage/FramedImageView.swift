//
//  FramedImageView.swift
//  PadoStudio
//
//  Created by gabi on 5/30/25.
//

import SwiftUI

struct FramedImageView: View {
    let image: UIImage?
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 550, height: 770)
        } else {
            Text("이미지를 불러올 수 없습니다.")
        }
    }
}

//#Preview {
//    FramedImageView(image: UIImage(named: "framed"))
//}
