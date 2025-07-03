import SwiftUI

struct GalleryToolbar: View {
    let title: String
    let onBack: () -> Void

    var body: some View {
        HStack {
            Button(action: onBack) {
                Circle()
                    .fill(Color.gray03)
                    .frame(
                        width: 50.scaled,
                        height: 50.scaled
                    )
                    .overlay(
                        Image(systemName: "chevron.left")
                            .foregroundColor(.primaryGreen)
                            .font(.eliceBold(size: 24.scaled))
                    )
            }

            Spacer()

            Text(title)
                .font(.styledRegular(size: 24.scaled))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .layoutPriority(1)
            
            Spacer()

        }
        .padding(.horizontal, 20.scaled)
        .padding(.vertical, 18.scaled)
        .padding(.trailing, 50.scaled)
        .background(Color.white)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    GalleryToolbar(
        title: "2025-06-12",
        onBack: {}
    )
}
