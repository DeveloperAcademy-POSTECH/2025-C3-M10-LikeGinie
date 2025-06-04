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
                    isSelected ? Color.primaryBlue : Color.gray05, lineWidth: 3
                )
                .background(Color.white)
                .frame(width: size, height: size)

            Image(asset.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: size * 0.83)
        }
    }
}
