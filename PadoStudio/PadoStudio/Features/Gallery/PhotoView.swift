//
//  PhotoView.swift
//  PadoStudio
//
//  Created by gabi on 5/28/25.
//


import SwiftData
import SwiftUI
#if DEBUG

struct PhotoView: View {
    let imageModel: GalleryData
    @Binding var reloadTrigger: Bool

    var body: some View {
        VStack {
            if let uiImage = UIImage(contentsOfFile: imageModel.filePath) {
                NavigationLink(
                    destination: PhotoDetailView(
                        reloadTrigger: $reloadTrigger, imageModel: imageModel)
                ) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 160)
                        .clipped()
                        .cornerRadius(8)
                        .shadow(radius: 2)
                }
            } else {
                VStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.primaryGreen)
                    Text("이미지 없음")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .frame(width: 120, height: 160)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .shadow(radius: 2)
            }
        }
    }
}
#endif

 
#if DEBUG
#Preview {
    PhotoView(
        imageModel: GalleryData(
            id: UUID(),
            date: Date(),
            filePath: Bundle.main.path(forResource: "sample", ofType: "jpg") ?? ""
        ),
        reloadTrigger: .constant(false)
    )
}
#endif
