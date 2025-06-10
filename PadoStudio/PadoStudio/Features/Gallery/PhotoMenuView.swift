//
//  PhotoMenuView.swift
//  PadoStudio
//
//  Created by gabi on 6/1/25.
//

import SwiftUI
import SwiftData

struct PhotoMenuView: View {
    let imageModel: GalleryData
    @State private var isSharing = false
    @State private var isWarning = false
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack {
            Menu {
                Button {
                    isSharing = true
                    print("공유렛츠고")
                } label : {
                    Label("공유하기", systemImage: "square.and.arrow.up")
                }
                Button(role: .destructive) {
                    isWarning = true
                    print("삭제렛쯔고")
                } label : {
                    Label("삭제하기", systemImage: "trash")
                }
            } label: {
                Circle()
                    .fill(Color.gray03)
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "ellipsis.circle")
                            .foregroundStyle(Color.primaryGreen)
                            .font(.eliceBold(size: 30))
                    )
            }
        }
        .sheet(isPresented: $isSharing) {
            if let uiImage = UIImage(contentsOfFile: imageModel.filePath) {
                FramedImageShareView(image: uiImage)
            } else {
                Text("이미지를 불러올 수 없습니다.")
            }
        }
        .alert("정말로 삭제하시겠습니까?", isPresented: $isWarning, actions: {
            Button("삭제하기", role: .destructive) {
                try? FileManager.default.removeItem(atPath: imageModel.filePath)
                modelContext.delete(imageModel)
                try? modelContext.save()
                
                dismiss()
            }
            Button("취소하기", role: .cancel) { }
        }, message: {
            Text("삭제 후엔 되돌릴 수 없습니다.")
        })
    }
}

//#Preview {
//    PhotoMenuView(imageName: "image4")
//}
