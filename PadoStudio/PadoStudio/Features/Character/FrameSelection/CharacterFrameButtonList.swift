//
//  CharacterFrameButtonList.swift
//  PadoStudio
//
//  Created by Oh Seojin on 6/9/25.
//

import SwiftUI

struct CharacterFrameButtonList: View {
    
    @EnvironmentObject var viewModel: CharacterFrameViewModel

    var body: some View {
        HStack(spacing: 32.scaled) {
            ForEach(
                CharacterFrameViewModel.Frame.allCases,
                id: \.self
            ) { f in
                Button {
                    viewModel.selectedFrame = f
                } label: {
                    VStack {
                        Image(f.btnImgName)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(100)
                            .clipShape(Circle())
                            .frame(
                                width: viewModel.selectedFrame
                                    == f ? 140 : 100
                            )
                            .overlay(  // 테두리 오버레이
                                Circle().stroke(
                                    viewModel.selectedFrame == f
                                        ? Color.primaryGreen
                                        : Color.gray05,
                                    lineWidth: viewModel
                                        .selectedFrame == f
                                        ? 8 : 1
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
    CharacterFrameButtonList()
        .environmentObject(CharacterFrameViewModel())
}
