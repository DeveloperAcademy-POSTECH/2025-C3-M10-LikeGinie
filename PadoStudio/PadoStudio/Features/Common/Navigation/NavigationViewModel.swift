//
//  NavigationViewModel.swift
//  PadoStudio
//
//  Created by eunsong on 5/28/25.
//

import SwiftUI

final class NavigationViewModel: ObservableObject {
    @Published var path = NavigationPath()

    func navigate(to route: AppRoute) {
        path.append(route)
    }

    func reset() {
        path = NavigationPath()
    }
}
