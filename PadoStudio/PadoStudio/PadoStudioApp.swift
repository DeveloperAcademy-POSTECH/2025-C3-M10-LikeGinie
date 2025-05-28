//
//  PadoStudioApp.swift
//  PadoStudio
//
//  Created by eunsong on 5/28/25.
//

import SwiftUI

@main
struct PadoStudioApp: App {

    var body: some Scene {
        WindowGroup {
            NavigationHostView()
                .environmentObject(NavigationViewModel())
        }
    }
}
