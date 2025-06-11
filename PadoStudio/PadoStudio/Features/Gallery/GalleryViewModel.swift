//
//  GalleryViewModel.swift
//  PadoStudio
//
//  Created by eunsong on 6/12/25.
//

import Dependencies
import Foundation
import SwiftUI

@MainActor
final class GalleryViewModel: ObservableObject {
    @Published var groupedSnapshots: [String: [GalleryData]] = [:]
    @Published var isEmpty: Bool = false

    @Dependency(\.getAllSnapshotsUseCase) var getAllSnapshotsUseCase

    func fetchSnapshots() async {
        do {
            let snapshots = try await getAllSnapshotsUseCase()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"

            let grouped = Dictionary(grouping: snapshots.map { GalleryData.from(snapshot: $0) }) { item in
                formatter.string(from: item.date)
            }

            groupedSnapshots = grouped
            isEmpty = snapshots.isEmpty
            print(">>> Snapshots count: \n", snapshots.count)
            print("snapshots: \(snapshots)")
        } catch {
            print("Error fetching snapshots: \(error)")
            groupedSnapshots = [:]
            isEmpty = true
        }
    }
}
