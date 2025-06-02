//
//  RoundButton.swift
//  PadoStudio
//
//  Created by gabi on 5/30/25.
//

import SwiftUI

struct RoundButton: View {
    let iconName: String
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 100, height: 100)
                    .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
                VStack {
                    Image(systemName: iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                    Text(label)
                }
            }
        }
    }
}

#Preview {
    RoundButton(iconName: "house", label: "얏호!", action: {print("버튼 눌렸다!")})
}
