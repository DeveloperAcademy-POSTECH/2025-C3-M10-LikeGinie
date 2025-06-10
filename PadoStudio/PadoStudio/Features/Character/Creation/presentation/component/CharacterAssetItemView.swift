//
//  CharacterAssetItemView.swift
//  PadoStudio
//
//  Created by eunsong on 6/5/25.
//

import SwiftUI

struct CharacterAssetItemView: View {
    let asset: CharacterAsset
    let isSelected: Bool
    let size: CGFloat

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(
                    isSelected ? Color.primaryGreen : Color.gray05, lineWidth: 6
                )
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: size, height: size)

            Image(asset.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: size * 0.83)
        }
    }
}
