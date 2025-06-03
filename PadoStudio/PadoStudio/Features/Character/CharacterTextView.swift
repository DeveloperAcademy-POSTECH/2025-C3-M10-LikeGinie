//
//  CharacterTextView.swift
//  PadoStudio
//
//  Created by 윤민경 on 6/3/25.
//

import SwiftUI

struct CharacterTextView: View {
    var body: some View {
        VStack{
            Text("완성된 캐릭터를 확인해주세요!")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.black)
        }
    }
    
}
#Preview {
    CharacterTextView()
}
