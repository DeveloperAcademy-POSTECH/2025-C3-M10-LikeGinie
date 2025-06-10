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
    @Environment(\.dismiss) var dismiss

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
                .padding(.top, 16)
            
            if galleryItems.isEmpty {
                EmptyGalleryView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
            } else {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(groupedItems.keys.sorted(by: >), id: \.self) { dateKey in
                            HStack {
                                Image("patrick")
                                    .resizable()
                                    .frame(width: 40, height: 30)
                                Text(dateKey)
                                    .font(.title3Bold)
                                    .padding(.vertical)
                            }
                            .padding(.horizontal)
                            
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
        .background(Color.lightYellow)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    GalleryView()
}
