//
//  GalleryToolbarView.swift
//  PadoStudio
//
//  Created by gabi on 6/9/25.
//

import SwiftUI

struct GalleryToolbarView: View {
    @Environment(\.dismiss) private var dismiss
    let imageModel: GalleryData
    
    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Circle()
                    .fill(Color.gray03)
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "chevron.left")
                            .foregroundStyle(Color.primaryGreen)
                            .font(.eliceBold(size: 30))
                    )
            }
            .padding(.horizontal, 40.scaled)
            Spacer()
            Text("\(galleryDateFormatter.string(from: imageModel.date))")
            Spacer()
            PhotoMenuView(imageModel: imageModel)
                .padding(.horizontal, 40.scaled)
        }
        .padding()
        .background(Color.white)
        .toolbar(.hidden, for: .navigationBar)
    }
}

//#Preview {
//    GalleryToolbarView()
//}
