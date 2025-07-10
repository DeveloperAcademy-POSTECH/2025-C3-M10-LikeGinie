//
//  EmptyGalleryView.swift
//  PadoStudio
//
//  Created by gabi on 6/7/25.
//

import SwiftUI

struct EmptyGalleryView: View {
    var body: some View {
        VStack {
            Image("ic_home_title")
            Text("no_saved_photos_message")
                .font(.title2Bold)
            Text("create_memory_suggestion")
                .font(.styledRegular(size: 20.scaled))
        }
    }
}

#Preview {
    EmptyGalleryView()
}
