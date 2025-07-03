//
//  PhotoDetailView.swift
//  PadoStudio
//
//  Created by gabi on 5/28/25.
//

import SwiftUI

struct PhotoDetailView: View {
    @StateObject private var viewModel = PhotoDetailViewModel()
    @Environment(\.dismiss) var dismiss
    @Binding var reloadTrigger: Bool
    let imageModel: GalleryData

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                GalleryToolbarViewWithMenu(
                    imageModel: imageModel,
                    title: imageModel.date.description,
                    onBack: {
                        reloadTrigger = true
                        dismiss()
                    },
                    onDelete: {
                        Task {
                            await viewModel.deleteSnapshot(imageModel)
                            reloadTrigger = true
                            dismiss()
                        }
                    }
                )

                Spacer()

                Group {
                    if let uiImage = UIImage(
                        contentsOfFile: imageModel.filePath)
                    {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(
                                width: ScreenRatioUtility.imageWidth,
                                height: ScreenRatioUtility.imageHeight
                            )
                            .cornerRadius(16.scaled)
                            .clipped()
                            .padding(.bottom, 30)
                    } else {
                        Text("이미지를 불러올 수 없습니다.")
                            .foregroundColor(.gray)
                    }
                }

                Spacer()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .background(Color.lightYellow)
    }
}

#Preview {
    // Dummy gallery data for preview
    let previewImagePath =
        Bundle.main.path(forResource: "framed", ofType: "png") ?? ""
    let dummyGalleryData = GalleryData(
        id: UUID(),
        date: Date(),
        filePath: previewImagePath
    )

    PhotoDetailView(
        reloadTrigger: .constant(false),
        imageModel: dummyGalleryData
    )
}
