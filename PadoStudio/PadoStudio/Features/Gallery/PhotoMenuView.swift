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
                    print("삭제렛쯔고")
                    print("삭제 버튼 눌렸다!")
                    if let index = images.firstIndex(of: imageName) {
                        images.remove(at: index)
                        dismiss()
                    }
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
    }
}

//#Preview {
//    PhotoMenuView(imageName: "image4")
//}
