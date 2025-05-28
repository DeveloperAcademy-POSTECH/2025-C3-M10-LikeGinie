//
//  PhotoDetailView.swift
//  PadoStudio
//
//  Created by gabi on 5/28/25.
//

import SwiftUI

struct PhotoDetailView: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
    }
}

#Preview {
    PhotoDetailView(imageName: "Image4")
}
