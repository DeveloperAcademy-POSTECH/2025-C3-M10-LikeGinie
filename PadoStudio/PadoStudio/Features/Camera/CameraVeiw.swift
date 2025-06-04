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


    
    var body: some View {
        ZStack {
            CameraPreview(session: camera.session)
                .onAppear {
                    camera.configure()
                }
                .frame(width: ScreenRatioUtility.imageWidth , height: ScreenRatioUtility.imageHeight )
                .cornerRadius(16.scaled)
                                   .clipped()

            Image("프레임")
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
                navModel.path.append(AppRoute.result(IdentifiableImage(image: img)))
            }
        }.environmentObject(camera) 
    }
}

#Preview {
    CameraView()
}
