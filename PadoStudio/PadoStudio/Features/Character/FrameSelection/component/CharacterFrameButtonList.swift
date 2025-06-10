//
//  CharacterFrameButtonList.swift
//  PadoStudio
//
//  Created by Oh Seojin on 6/9/25.
//

import SwiftUI

struct CharacterFrameButtonList: View {
    let selectedFrame: CharacterFrameViewModel.Frame
    let onFrameSelected: (CharacterFrameViewModel.Frame) -> Void

    var body: some View {
        HStack(spacing: 32.scaled) {
            ForEach(CharacterFrameViewModel.Frame.allCases, id: \.self) { f in
                Button {
                    onFrameSelected(f)
                } label: {
                    VStack {
                        Image(f.btnImgName)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(100)
                            .clipShape(Circle())
                            .frame(width: selectedFrame == f ? 140 : 100)
                            .overlay(
                                Circle().stroke(
                                    selectedFrame == f ? Color.primaryGreen : Color.gray05,
                                    lineWidth: selectedFrame == f ? 8 : 1
                                )
                            )
                    }
                }
            }
        }
        .padding(.top, 30.scaled)
        .padding(.bottom, 30.scaled)
        .padding(.horizontal, 8)
    }
}

#Preview {
    CharacterFrameButtonList(
        selectedFrame: .sea,
        onFrameSelected: { _ in }
    )
}
