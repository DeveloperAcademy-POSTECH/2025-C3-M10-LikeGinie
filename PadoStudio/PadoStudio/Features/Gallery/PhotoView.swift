//
//  PhotoView.swift
//  PadoStudio
//
//  Created by gabi on 5/28/25.
//

import SwiftUI

struct PhotoView: View {
    let imageName: String
    @Binding var images: [String]
    
    var body: some View {
        NavigationLink {
            PhotoDetailView(imageName: imageName)
                .navigationTitle("사진")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        PhotoMenuView(imageName: imageName, images: $images)
                    }
                }
        } label: {
            Image(imageName)
                .resizable()
                .scaledToFit()
        }
    }
}

//#Preview {
//    PhotoView(imageName: "Image2")
//}
