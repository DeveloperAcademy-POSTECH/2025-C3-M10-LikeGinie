//
//  CharacterTextView.swift
//  PadoStudio
//
//  Created by 윤민경 on 6/3/25.
//

import SwiftUI

struct CharacterTextView: View {
    var body: some View {
        GeometryReader { proxy in
            HStack(alignment: .firstTextBaseline, spacing: 2) { // 👈 베이스라인 정렬!
                Text("완성된 캐릭터")
                    .font(.eliceBoldResponsive(size: 20, proxy: proxy))
                    .foregroundColor(.black)
                Text("를 확인해주세요!")
                    .font(.styledRegularResponsive(size: 15, proxy: proxy))
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(height: 60)
    }
}
#Preview {
    CharacterTextView()
}
