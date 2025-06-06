//
//  GalleryView.swift
//  PadoStudio
//
//  Created by gabi on 5/28/25.
//

import SwiftUI
import SwiftData

struct GalleryView: View {
    @Query var galleryItems: [GalleryData]
    @State private var images = [
        "Feathers",
        "Image1",
        "Image2",
        "Image3",
        "Image4",
        "Image5",
        "Image6"
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
//        ScrollView {
//            LazyVGrid(columns: columns) {
//                ForEach(images.indices, id: \.self) { index in
//                    PhotoView(imageName: images[index], images: $images)
//                }
//            }
//        }
        List(galleryItems) { item in
            
        }
    }
}

#Preview {
    GalleryView()
}
