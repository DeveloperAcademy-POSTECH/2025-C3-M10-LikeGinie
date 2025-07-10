//
//  FramedImageTextView.swift
//  PadoStudio
//
//  Created by gabi on 5/30/25.
//

import SwiftUI

struct FramedImageTextView: View {
    var body: some View {
        VStack {
            Text("photo_shoot_complete_title")
                .font(.styledRegular(size: 25.scaled))
                .bold()
            Text("share_photo_suggestion")
                .font(.styledRegular(size: 15.scaled))
        }
    }
}

#Preview {
    FramedImageTextView()
}
