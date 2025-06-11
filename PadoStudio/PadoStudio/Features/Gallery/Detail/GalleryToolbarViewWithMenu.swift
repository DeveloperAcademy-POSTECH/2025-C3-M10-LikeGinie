//
//  GalleryToolbarView.swift
//  PadoStudio
//
//  Created by gabi on 6/10/25.
//

import SwiftUI

struct GalleryToolbarViewWithMenu: View {
    let imageModel: GalleryData
    let title: String
    let onBack: () -> Void
    let onDelete: () -> Void

    private var toolbarTitle: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: imageModel.date)
    }

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
            
            Text(toolbarTitle)
                .font(.styledRegular(size: 24.scaled))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .layoutPriority(1)

            Spacer()

            PhotoMenuView(imageModel: imageModel, deleteAction: onDelete)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color.white)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    GalleryToolbarViewWithMenu(
        imageModel: GalleryData(
            id: UUID(),
            date: Date(),
            filePath:
                "framed"
        ),
        title: "2025-06-12",
        onBack: {},
        onDelete: {}
    )
}
