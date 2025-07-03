//
//  CharacterRowView.swift
//  PadoStudio
//
//  Created by eunsong on 6/10/25.
//


import SwiftUI

struct CharacterRowView: View {
    let characterImages: [UIImage]
    
    var body: some View {
        HStack(spacing: -5.scaled) {
            Spacer()
            
            // 캐릭터 이미지들 표시
            ForEach(Array(characterImages.enumerated()), id: \.offset) { index, image in
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44.scaled, height: 55.scaled)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.white, lineWidth: 1)
                    )
            }
        }
        .onAppear {
            print("CharacterRowView appeared with \(characterImages.count) images")
        }
    }
}

#Preview {
    // 미리보기용 더미 이미지들 생성
    let dummyImages = [
        UIImage(named: "origin-standard") ?? UIImage(),
        UIImage(named: "origin-standard") ?? UIImage(),
        UIImage(named: "origin-standard") ?? UIImage(),
        UIImage(named: "origin-standard") ?? UIImage(),
        UIImage(named: "origin-standard") ?? UIImage(),
        UIImage(named: "origin-standard") ?? UIImage()
    ]

    VStack(spacing: 20.scaled) {
        // 단독 미리보기
        CharacterRowView(characterImages: dummyImages)
            .frame(width: 300.scaled)
            .background(Color.gray.opacity(0.1))
    }
    .padding()
}
