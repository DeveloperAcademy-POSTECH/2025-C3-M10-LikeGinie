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
        HStack(alignment: .firstTextBaseline, spacing: 2.scaled) {
            Text("check_completed_character_message")
                .font(.title2BoldResponsive(proxy))
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        //            .frame(height: 60.scaled)

    }
}
#Preview {
    GeometryReader { proxy in
        CharacterTextView(proxy: proxy)
    }
}
