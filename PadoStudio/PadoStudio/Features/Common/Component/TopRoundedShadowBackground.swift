//
//  TopRoundedShadowBackground.swift
//  PadoStudio
//
//  Created by eunsong on 6/11/25.
//

import SwiftUI

struct TopRoundedShadowBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12.scaled)
            .fill(Color.white)
            .shadow(color: Color.gray05, radius: 10, x: 0, y: -2)
    }
}

#Preview {
    TopRoundedShadowBackground()
}
