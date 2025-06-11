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
            Text("촬영이 완료되었어요!")
                .font(.styledRegular(size: 25.scaled))
                .bold()
            Text("함께한 사진을 공유해보세요")
                .font(.styledRegular(size: 15.scaled))
        }
    }
}

#Preview {
    FramedImageTextView()
}
