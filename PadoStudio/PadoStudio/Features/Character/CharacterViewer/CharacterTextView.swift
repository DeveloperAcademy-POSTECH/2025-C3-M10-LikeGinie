//
//  CharacterTextView.swift
//  PadoStudio
//
//  Created by 윤민경 on 6/3/25.
//

import SwiftUI

struct CharacterTextView: View {
    let proxy: GeometryProxy

    var body: some View {
            HStack(alignment: .firstTextBaseline, spacing: 2) {  // 👈 베이스라인 정렬!
                Text("완성된 캐릭터")
                    .font(.title2BoldResponsive(proxy))
                Text("를 확인해주세요!")
                    .font(.title3RegularResponsive(size: 20, proxy: proxy))
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: 60)

    }
}
#Preview {
    GeometryReader { proxy in
        CharacterTextView(proxy: proxy)
    }
}
