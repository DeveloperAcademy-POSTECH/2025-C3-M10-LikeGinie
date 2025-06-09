//
//  SquareButton.swift
//  PadoStudio
//
//  Created by gabi on 6/3/25.
//

import SwiftUI

enum ButtonColor {
    case green
    case gray
    
    var backgroundColor: Color {
        switch self {
        case .green:
            return Color.primaryGreen
        case .gray:
            return Color.gray04
        }
    }
    
    var textColor: Color {
        switch self {
        case .green:
            return Color.white
        case .gray:
            return Color.black
        }
    }
}

struct SquareButton: View {
    let color: ButtonColor
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(color.backgroundColor)
                    .frame(width: 300, height: 80)
                
                VStack {
                    Text(label)
                        .font(.styledRegular(size: 20.scaled))
                        .foregroundStyle(color.textColor)
                }
            }
        }
    }
}

#Preview {
    SquareButton(color: .gray, label: "초기화", action: {print("야호!")})
}
