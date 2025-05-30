//
//  FramedImageView.swift
//  PadoStudio
//
//  Created by gabi on 5/30/25.
//

import SwiftUI

struct FramedImageView: View {
    var body: some View {
        Image("framed")
            .resizable()
            .scaledToFit()
            .frame(width: 550, height: 770)
    }
}

#Preview {
    FramedImageView()
}
