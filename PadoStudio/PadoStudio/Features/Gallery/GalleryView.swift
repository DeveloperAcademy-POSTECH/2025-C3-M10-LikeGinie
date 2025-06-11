//
//  GalleryView.swift
//  PadoStudio
//
//  Created by gabi on 5/28/25.
//

import SwiftData
import SwiftUI

struct GalleryView: View {
    @StateObject private var viewModel = GalleryViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var reloadTrigger = false

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        VStack {
            GalleryToolbar(
                title: "갤러리",
                onBack: { dismiss() }
            )
            .background(Color.white)

            if viewModel.isEmpty {
                EmptyGalleryView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(
                            viewModel.groupedSnapshots.keys.sorted(by: >),
                            id: \.self
                        ) { dateKey in
                            VStack(alignment: .leading, spacing: 4) {
                                HStack(spacing: 8) {
                                    Image("patrick")
                                        .resizable()
                                        .frame(width: 20.scaled, height: 20.scaled)
                                    Text(dateKey)
                                        .font(.title3Bold)
                                }
                                .padding(.horizontal, 14.scaled)
                            }

                            LazyVGrid(columns: columns) {
                                ForEach(
                                    viewModel.groupedSnapshots[dateKey] ?? [],
                                    id: \.id
                                ) { snapshot in
                                    PhotoView(
                                        imageModel: snapshot,
                                        reloadTrigger: $reloadTrigger)
                                }
                            }
                        }
                    }
                }
                .padding(.top)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchSnapshots()
            }
        }
        .onChange(of: reloadTrigger) {
            Task {
                await viewModel.fetchSnapshots()
            }
        }
        .background(Color.lightYellow)
    }
}

#Preview {
    GalleryView()
}
