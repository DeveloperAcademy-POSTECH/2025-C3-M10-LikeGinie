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
        VStack {
            ToolbarView(title: "갤러리", titleColor: .black)
                .background(Color.white)
            if galleryItems.isEmpty {
                EmptyGalleryView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(groupedItems.keys.sorted(by: >), id: \.self) { dateKey in
                            Text(dateKey)
                                .font(.title3Bold)
                                .padding(.vertical)
                            
                            LazyVGrid(columns: columns) {
                                ForEach(groupedItems[dateKey] ?? []) { item in
                                    PhotoView(imageModel: item)
                                }
                                
                            }
                        }
                    }
                }
                .padding(.top)
            }
        }
    }
}

#Preview {
    GalleryView()
}
