//
//  PhotoView.swift
//  PadoStudio
//
//  Created by gabi on 5/28/25.
//

import SwiftUI
import SwiftData

struct PhotoView: View {
    let imageModel: GalleryData

    var body: some View {
        if let uiImage = UIImage(contentsOfFile: imageModel.filePath) {
            NavigationLink(destination: PhotoDetailView(imageModel: imageModel)) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            }
        } else {
            Color.gray
                .overlay(Text("오류").foregroundStyle(Color.white))
        }
    }
}

//#Preview {
//    PhotoView(imageName: "Image2")
//}
