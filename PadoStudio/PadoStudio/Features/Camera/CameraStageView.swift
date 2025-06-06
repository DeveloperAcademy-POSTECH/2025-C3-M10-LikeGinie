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
    

    
    var body: some View {
        VStack {
            if let image = image {
                ZStack {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: ScreenRatioUtility.imageWidth , height: ScreenRatioUtility.imageHeight )
                    
                }
                .padding()
            } else {
                Text("이미지를 불러올 수 없습니다.")
                    .foregroundColor(.gray)
            }
            
            
            VStack {
                Spacer()
                ZStack {
                    
                    Button(action: {
                        print("버튼 클릭됨")
                        guard let finalImage = image else {
                            print("최종 이미지가 없음")
                            return
                        }
                        print("이미지체크뷰로 이동")
                        let identifiableImage = IdentifiableImage(image: finalImage)
                        navModel.path.append(AppRoute.ImageCheck(identifiableImage))
                    }) {
                        Image("download")
                            .resizable()
                            .frame(width: 70.scaled, height: 70.scaled)
                    }

                    
                    HStack {
                        Button(action: {
                            print("재촬영 눌림!")
                            onRetake()
                        }) {
                            Image("cameraagain")
                                .resizable()
                                .frame(width: 40.scaled, height: 40.scaled)
                        }
                        .padding(.leading, 30.scaled)

                        Spacer()
                    }
                }
                .padding(.bottom, 30.scaled)
            }


                  }.navigationBarHidden(true)
    }
}


//#Preview {
//    CameraStageView(image: , onRetake: )
//}
