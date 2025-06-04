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
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.width * 4 / 3)
                .cornerRadius(16)
                .clipped()

            Image("프레임")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.width * 4 / 3)
                .allowsHitTesting(false)

            if isCountingDown {
                Text("\(countdown)")
                    .font(.system(size: 100, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 10)
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
                            .frame(width: 70, height: 70)
                            .shadow(radius: 4)
                    }
                    .padding(.bottom, 30)
                    .padding(.leading, 100)
                    .disabled(isCountingDown)

                    Button(action: {
                        camera.switchCamera()
                    }) {
                        Image("camerachange")
                            .resizable()
                            .frame(width: 40, height: 30)
                            .padding(.leading, 60)
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
