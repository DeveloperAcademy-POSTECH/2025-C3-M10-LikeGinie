//
//  PadoStudioApp.swift
//  PadoStudio
//
//  Created by eunsong on 5/28/25.
//

import SwiftUI

@main
struct PadoStudioApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
