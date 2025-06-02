//
//  CameraStageView.swift
//  PadoStudio
//
//  Created by kim yijun on 5/29/25.
//

import SwiftUI

struct CameraStageView: View {
    let image: UIImage?
    var onRetake: () -> Void

    var body: some View {
        VStack {
            if let image = image {
                ZStack {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 500)
                        .cornerRadius(16)

                    Image("프레임")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 500)
                        .allowsHitTesting(false) // 터치 방해 X
                }
                .padding()
            } else {
                Text("이미지를 불러올 수 없습니다.")
                  
            }

            Spacer()
        }
        .navigationTitle("촬영 결과")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: Button("재촬영") {
            onRetake()
        })
    }
}



//#Preview {
//    CameraStageView(image: , onRetake: )
//}
