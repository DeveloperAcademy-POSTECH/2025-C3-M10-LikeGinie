//
//  FramedImageShareView.swift
//  PadoStudio
//
//  Created by gabi on 5/30/25.
//

import SwiftUI

struct FramedImageShareView: UIViewControllerRepresentable {
    let image: UIImage
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let items = [image]
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}

