//
//  SnapshotRendererHelper.swift
//  PadoStudio
//
//  Created by eunsong on 6/9/25.
//

import SwiftUI

enum SnapshotRendererHelper {
    @MainActor
    static func renderCharacterPreview(
        from view: some View,
        size: CGSize
    ) -> UIImage? {
        let renderer = ImageRenderer(content: view)
        renderer.scale = UIScreen.main.scale
        renderer.proposedSize = .init(size)
        renderer.isOpaque = false
        return renderer.uiImage
    }
}
