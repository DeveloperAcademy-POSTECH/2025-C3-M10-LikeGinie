//
//  PhotoMenuView.swift
//  PadoStudio
//
//  Created by gabi on 6/1/25.
//

import SwiftUI

struct PhotoMenuView: View {
    let imageName: String
    @State private var isSharing = false
    @State private var isWarning = false
    @Binding var images: [String]
    @Environment(\.dismiss) var dismiss
    
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
                Image(systemName: "ellipsis.circle")
            }
        }
        .sheet(isPresented: $isSharing) {
            if let image = UIImage(named: imageName) {
                FramedImageShareView(image: image)
            } else {
                Text("이미지를 불러올 수 없습니다.")
            }
        }
        .alert("정말로 삭제하시겠습니까?", isPresented: $isWarning, actions: {
            Button("삭제하기", role: .destructive) {
                if let index = images.firstIndex(of: imageName) {
                    images.remove(at: index)
                    dismiss()
                }
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
