//
//  PhotoDetailView.swift
//  PadoStudio
//
//  Created by gabi on 5/28/25.
//

import SwiftUI

struct PhotoDetailView: View {
    let imageModel: GalleryData
    
    var body: some View {
        VStack {
            GalleryToolbarView(imageModel: imageModel)
            Group {
                if let uiImage = UIImage(contentsOfFile: imageModel.filePath) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("이미지를 불러올 수 없습니다.")
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
}
