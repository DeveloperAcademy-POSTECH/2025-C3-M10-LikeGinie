//
//  SnapshotRenderer.swift
//  PadoStudio
//
//  Created by eunsong on 6/9/25.
//
import SwiftUI

enum SnapshotRenderer {
    static func renderImage<V: View>(
        from view: V,
        size: CGSize
    ) -> UIImage {
        let controller = UIHostingController(rootView: view)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            controller.view.drawHierarchy(
                in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
