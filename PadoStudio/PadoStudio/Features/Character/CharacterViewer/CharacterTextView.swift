//
//  CharacterTextView.swift
//  PadoStudio
//
//  Created by 윤민경 on 6/3/25.
//

import SwiftUI

struct CharacterTextView: View {
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 2.scaled) {  // 👈 베이스라인 정렬!
            Text("완성된 캐릭터")
                .font(.title2Bold)
                .foregroundColor(.black)
            Text("를 확인해주세요!")
                .font(.title3)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(height: 60.scaled)

    }
}
#Preview {
    CharacterTextView()
}
