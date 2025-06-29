//
//  PadoStudioApp.swift
//  PadoStudio
//
//  Created by eunsong on 5/28/25.
//

import SwiftUI

@main
struct PadoStudioApp: App {
    init() {
        UIView.appearance(whenContainedInInstancesOf: [UIWindow.self]).overrideUserInterfaceStyle = .light
        // DatabaseFileManager.removeStoreFileIfExists() // 주석 처리: 데이터 지속성을 위해 제s
    }

    var body: some Scene {
        WindowGroup {
            NavigationHostView()
                .environmentObject(NavigationViewModel())
        }
        .modelContainer(for: [SnapshotEntity.self, CharacterEntity.self])
    }
}
