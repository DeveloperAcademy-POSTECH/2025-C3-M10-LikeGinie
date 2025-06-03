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
    @EnvironmentObject var navModel: NavigationViewModel
    @StateObject private var camera = CameraViewModel()
    
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
                        .allowsHitTesting(false)
                }
                .padding()
            } else {
                Text("이미지를 불러올 수 없습니다.")
                    .foregroundColor(.gray)
            }

            Spacer()

            HStack{
                
                Button(action: {
                    print("재촬영 눌림!") 
                onRetake()
            }) {
                Image("cameraagain")
            }
                
                Button(action: {
                    print("버튼 클릭됨")
                    guard let base = image else {
                        print("기본 이미지가 없음")
                        return
                    }
                    
                    print("이미지 합성 시작")
                    if let composed = camera.composeFramedImage(baseImage: base) {
                        print("이미지 합성 성공")
                        let identifiableImage = IdentifiableImage(image: composed)
                        navModel.path.append(AppRoute.ImageCheck(identifiableImage))
                    } else {
                        print("이미지 합성 실패")
                    }
                }) {
                    Image("download")
                }


                  }
          
        }
        .navigationBarHidden(true) 
    }
}


//#Preview {
//    CameraStageView(image: , onRetake: )
//}
