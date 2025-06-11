//
//  GalleryToolbarView.swift
//  PadoStudio
//
//  Created by gabi on 6/10/25.
//

import SwiftUI

struct GalleryToolbarView: View {
    @Environment(\.dismiss) private var dismiss
    let imageModel: GalleryData
    
    var body: some View {
        HStack {
            Button {
                dismiss()
            } label : {
                Circle()
                    .fill(Color.gray03)
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "chevron.left")
                            .foregroundColor(.primaryGreen)
                            .font(.eliceBold(size: 30))
                    )
            }
            .padding(.horizontal, 40)
            Spacer()
            Text("\(galleryDateFormatter.string(from: imageModel.date))")
                .font(.styledRegular(size: 32))
            Spacer()
            Button {
                PhotoMenuView(imageModel: imageModel)
            } label : {
                Circle()
                    .fill(Color.gray03)
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "ellipsis.circle")
                            .foregroundColor(.primaryGreen)
                            .font(.eliceBold(size: 30))
                    )
            }
            .padding(.horizontal, 40)
        }
        
    }
}
