//
//  CameraVeiw.swift
//  PadoStudioSample
//
//  Created by kim yijun on 5/28/25.
//


import SwiftUI
import AVFoundation

struct CameraView: View {
    @StateObject private var camera = CameraViewModel()
    @State private var countdown = 5
    @State private var isCountingDown = false
    @EnvironmentObject var navModel: NavigationViewModel

    @State private var characters: [String] = ["Asset5", "Asset5", "Asset5","Asset5", "Asset5", "Asset5"]
    
    
    var body: some View {
        ZStack {
            
            CameraPreview(session: camera.session)
                .onAppear {
                    camera.configure()
                    camera.selectedCharacters = characters // 캐릭터 정보를 뷰모델에 설정
                }
                .frame(width: ScreenRatioUtility.imageWidth , height: ScreenRatioUtility.imageHeight, alignment: .top )
                .cornerRadius(16.scaled)
                .clipped()
                

            Image("Frame1")
                .resizable()
                .scaledToFit()
                .frame(width: ScreenRatioUtility.imageWidth , height: ScreenRatioUtility.imageHeight )
                .allowsHitTesting(false)
            

            if isCountingDown {
                Text("\(countdown)")
                    .font(.system(size: 100.scaled , weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 10.scaled)
            }
           
            VStack {
                
                Spacer()
                
                HStack(spacing: -10.scaled) {
                                 ForEach(characters, id: \.self) { character in
                                     Image(character)
                                         .resizable()
                                         .aspectRatio(contentMode: .fit)
                                         .frame(width: min( 150.scaled, (ScreenRatioUtility.imageWidth) / CGFloat(characters.count)),
                                                height: min(150.scaled, (ScreenRatioUtility.imageWidth) / CGFloat(characters.count)))
                                 }
                             }
                             .frame(maxWidth: ScreenRatioUtility.imageWidth) // 프레임 안에 유지
                              .padding(.bottom, 50.scaled)
                
                HStack {
                    Button(action: {
                        isCountingDown = true
                        countdown = 5

                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                            countdown -= 1
                            if countdown == 0 {
                                timer.invalidate()
                                isCountingDown = false
                                camera.takePhoto()
                            }
                        }
                    }) {
                        Image("CameraFrame")
                            .resizable()
                            .frame(width: 70.scaled, height: 70.scaled)
                           
                    }
                    .padding(.bottom, 30.scaled)
                    .padding(.leading, 100.scaled)
                    .disabled(isCountingDown)

                    Button(action: {
                        camera.switchCamera()
                    }) {
                        Image("camerachange")
                            .resizable()
                            .frame(width: 40.scaled, height: 40.scaled)
                            .padding(.leading, 60.scaled)
                    }
                }
            }
        }
        .onChange(of: camera.capturedImage) { newImage in
            if let img = newImage {
                // 캐릭터 정보를 뷰모델에 설정하고 즉시 합성
                camera.selectedCharacters = characters
                if let composedImage = camera.composeFramedImageWithCharacters(baseImage: img) {
                    // 합성된 이미지를 전달 (캐릭터 정보는 더 이상 필요 없음)
                    navModel.path.append(AppRoute.result(IdentifiableImage(image: composedImage)))
                } else {
                    // 합성 실패시 원본 이미지 전달
                    navModel.path.append(AppRoute.result(IdentifiableImage(image: img)))
                }
            }
        }.environmentObject(camera)
    }
}

#Preview {
    CameraView()
}
