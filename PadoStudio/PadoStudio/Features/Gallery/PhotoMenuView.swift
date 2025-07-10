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
    let deleteAction: () -> Void
    @State private var isSharing = false
    @State private var isWarning = false
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack {
            Menu {
                Button {
                    isSharing = true
                    print("공유렛츠고")
                } label : {
                    Label("share_button_label", systemImage: "square.and.arrow.up")
                }
                Button(role: .destructive) {
                    isWarning = true
                    print("삭제렛쯔고")
                } label : {
                    Label("delete_button_label", systemImage: "trash")
                }
            } label: {
                Circle()
                    .fill(Color.gray03)
                    .frame(width: 50.scaled, height: 50.scaled)
                    .overlay(
                        Image(systemName: "ellipsis.circle")
                            .foregroundColor(.primaryGreen)
                            .font(.eliceBold(size: 24.scaled))
                    )
            }
        }
        .sheet(isPresented: $isSharing) {
            if let uiImage = UIImage(contentsOfFile: imageModel.filePath) {
                FramedImageShareView(image: uiImage)
            } else {
                Text("image_load_error_message")
            }
        }
        .alert("delete_confirmation_alert_title", isPresented: $isWarning, actions: {
            Button("delete_button_label", role: .destructive) {
                deleteAction()
            }
            Button("cancel_button_label", role: .cancel) { }
        }, message: {
            Text("delete_warning_message")
        })
    }
}
