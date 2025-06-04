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
                    .fill(Color.primaryGreen)
                    .frame(width: 200, height: 200)
                
                VStack {
                    Image(systemName: iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 64)
                        .foregroundStyle(.white)
                    Text(label)
                        .font(.system(size: 24))
                        .fontWeight(.black)
                        .foregroundStyle(.white)
                }
            }
        }
    }
}

#Preview {
    RoundButton(iconName: "house", label: "얏호!", action: {print("버튼 눌렸다!")})
}
