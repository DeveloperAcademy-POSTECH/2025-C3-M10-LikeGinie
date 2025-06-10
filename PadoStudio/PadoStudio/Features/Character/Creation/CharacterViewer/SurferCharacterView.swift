//
//  SurferCharacterView.swift
//  PadoStudio
//
//  Created by 윤민경 on 6/3/25.
//

import SwiftUI

struct SurferCharacterView: View {
    let characterImages = Array(repeating: "Asset5", count: 6)

    var body: some View {
        HStack{
            ForEach(0..<characterImages.count, id: \.self) { idx in
                Image(characterImages[idx])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 320)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center) // 가운데 정렬
    }
}

#Preview {
    SurferCharacterView()
}
