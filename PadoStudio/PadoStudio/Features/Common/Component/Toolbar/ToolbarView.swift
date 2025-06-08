import SwiftUI

enum ToolbarTitleColor {
    case black
    case white
    
    var color: Color {
        switch self {
        case .black: return .black
        case .white: return .white
        }
    }
}

struct ToolbarView: View {
    let title: String
    let titleColor: ToolbarTitleColor
    @Environment(\.dismiss) private var dismiss
    @Environment(\.horizontalSizeClass) private var sizeClass

    var body: some View {
        if sizeClass == .regular {
            ToolbarPadLayout(title: title, titleColor: titleColor)
        } else {
            ToolbarPhoneLayout(title: title, titleColor: titleColor)
        }
    }
}

//아이폰
struct ToolbarPhoneLayout: View {
    let title: String
    let titleColor: ToolbarTitleColor
    @Environment(\.dismiss) private var dismiss   // 추가

    var body: some View {
        HStack {
            Color.clear.frame(width: 16)
            Button(action: {
                dismiss()   // 뒤로가기 동작
            }) {
                Circle()
                    .fill(Color.white)
                    .frame(width: 44, height: 44)
                    .overlay(
                        Image(systemName: "chevron.left")
                            .foregroundColor(.primaryGreen)
                            .font(.eliceBold(size: 20))
                    )
            }
            .frame(width: 44, height: 44)
            Spacer()
            Text(title)
                .font(.styledRegular(size: 25))
                .foregroundColor(titleColor.color)
                .multilineTextAlignment(.center)
            Spacer()
            Color.clear.frame(width: 44)
        }
        .frame(height: 60)
    }
}

//아이패드
struct ToolbarPadLayout: View {
    let title: String
    let titleColor: ToolbarTitleColor
    @Environment(\.dismiss) private var dismiss   // 추가

    var body: some View {
        HStack {
            Color.clear.frame(width: 40)
            Button(action: {
                dismiss()   // 뒤로가기 동작
            }) {
                Circle()
                    .fill(Color.white)
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "chevron.left")
                            .foregroundColor(.primaryGreen)
                            .font(.eliceBold(size: 30))
                    )
            }
            .frame(width: 80, height: 80)
            Spacer()
            Text(title)
                .font(.styledRegular(size: 32))
                .foregroundColor(titleColor.color)
                .multilineTextAlignment(.center)
            Spacer()
            Color.clear.frame(width: 100)
        }
        .frame(height: 80)
    }
}
