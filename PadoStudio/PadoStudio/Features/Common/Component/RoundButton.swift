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
                    .frame(width: 80.scaled, height: 80.scaled)
                
                VStack {
                    Image(systemName: iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30.scaled)
                        .foregroundStyle(.white)
                    Text(label)
                        .font(.styledRegular(size: 15.scaled))
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
