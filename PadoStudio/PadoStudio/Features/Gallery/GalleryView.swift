//
//  GalleryView.swift
//  PadoStudio
//
//  Created by gabi on 5/28/25.
//

import SwiftUI

struct GalleryView: View {
    var images = [
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
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(0..<images.count, id: \.description) { index in
                        PhotoView(imageName: "\(images[index])")
                        
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    GalleryView()
}
