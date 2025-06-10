//
//  ViewSnapshot.swift
//  PadoStudio
//
//  Created by eunsong on 6/9/25.
//

import SwiftUI

extension View {
    func snapshot(size: CGSize) -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = size
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
        }
    }
}
