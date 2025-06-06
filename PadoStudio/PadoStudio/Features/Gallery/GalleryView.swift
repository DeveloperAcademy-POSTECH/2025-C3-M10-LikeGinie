//
//  GalleryView.swift
//  PadoStudio
//
//  Created by gabi on 5/28/25.
//

import SwiftUI
import SwiftData

let galleryDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}()

struct GalleryView: View {
    @Query var galleryItems: [GalleryData]
    var groupedItems: [String: [GalleryData]] {
        return Dictionary(grouping: galleryItems) { item in
            galleryDateFormatter.string(from: item.date)
        }
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        if galleryItems.isEmpty {
            EmptyGalleryView()
        } else {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(groupedItems.keys.sorted(), id: \.self) { dateKey in
                        Section(header: Text(dateKey)) {
                            ForEach(groupedItems[dateKey] ?? []) { item in
                                PhotoView(imageModel: item)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    GalleryView()
}
