//
//  PhotoView.swift
//  PadoStudio
//
//  Created by gabi on 5/28/25.
//


import SwiftData
import SwiftUI

struct PhotoView: View {
    let imageModel: GalleryData
    @Binding var reloadTrigger: Bool
    
    
    private var imageSize: CGSize {
            let columnCount: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 4 : 3
            let spacing: CGFloat = 8.scaled * (columnCount - 1)
            let padding: CGFloat = 28.scaled // 좌우 패딩
            let availableWidth = ScreenRatioUtility.screenWidth - spacing - padding
            let width = availableWidth / columnCount
            let height = width * 4/3 // 4:3 비율 유지
            return CGSize(width: width, height: height)
        }
    

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
                        .frame(width: imageSize.width, height: imageSize.height)
                        .clipped()
                        .cornerRadius(8)
                        .shadow(radius: 2)
                }
            } else {
                VStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40.scaled, height: 40.scaled)
                        .foregroundColor(.primaryGreen)
                    Text(LocalizedStringKey("no_image"))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .frame(width: imageSize.width, height: imageSize.height)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .shadow(radius: 2)
            }
        }
    }
}

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
