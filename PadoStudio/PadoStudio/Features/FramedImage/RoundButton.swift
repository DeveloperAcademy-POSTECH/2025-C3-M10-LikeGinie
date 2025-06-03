//
//  RoundButton.swift
//  PadoStudio
//
//  Created by gabi on 5/30/25.
//

import SwiftUI

enum ButtonColor: String {
    case green
    case white
    
    var buttonColor: Color {
        switch self {
            case .green:
                return Color.primaryGreen
            case .white:
                return Color.white
        }
    }
}

struct RoundButton: View {
    let backgroundColor: ButtonColor
    let iconName: String
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle(backgroundColor.buttonColor)
                    .fill()
                    .frame(width: 200, height: 200)
                
                VStack {
                    Image(systemName: iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 64)
                        .foregroundStyle(.white)
                    Text(label)
                        .font(.system(size: 24))
                        .bold()
                        .foregroundStyle(.white)
                }
            }
        }
    }
}

#Preview {
    RoundButton(backgroundColor: .green, iconName: "house", label: "얏호!", action: {print("버튼 눌렸다!")})
}
