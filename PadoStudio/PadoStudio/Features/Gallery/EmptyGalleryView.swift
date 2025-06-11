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
            Text("저장된 사진이 없습니다 :(")
                .font(.title2Bold)
            Text("파도 사진관에서 오늘의 추억을 남겨보세요!")
                .font(.styledRegular(size: 20))
        }
    }
}

#Preview {
    EmptyGalleryView()
}
