//
//  ToolbarHiddenWrapper.swift
//  PadoStudio
//
//  Created by eunsong on 6/11/25.
//
import SwiftUI

struct ToolbarHiddenWrapper<Content: View>: View {
    var content: Content
    var body: some View {
        content
            .toolbar(.hidden, for: .navigationBar)
    }
}
