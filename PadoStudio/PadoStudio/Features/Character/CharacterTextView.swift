//
//  CharacterTextView.swift
//  PadoStudio
//
//  Created by 윤민경 on 6/3/25.
//

import SwiftUI

struct CharacterTextView: View {
    var body: some View {
        HStack(spacing: 2) { // 간격을 2로 매우 좁게!
            Text("완성된 캐릭터")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .foregroundColor(.black)
            Text("를 확인해주세요!")
                .font(.system(size: 30))
        }
    }
}

#Preview {
    CharacterTextView()
}
