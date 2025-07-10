//
//  CameraVeiw.swift
//  PadoStudioSample
//
//  Created by kim yijun on 5/28/25.
//

import AVFoundation
import SwiftUI

struct CameraView: View {
    @StateObject private var camera = CameraViewModel()
    @State private var countdown = 5
    @State private var isCountingDown = false
    @EnvironmentObject var navModel: NavigationViewModel

    let frameImagePath: String

    var body: some View {
        ZStack {
            CameraPreview(session: camera.session)
                .onAppear {
                    camera.configure()
                }
                .frame(
                    width: ScreenRatioUtility.imageWidth,
                    height: ScreenRatioUtility.imageHeight, alignment: .top
                )
                .cornerRadius(16.scaled)
                .clipped()

            if let uiImage = UIImage(contentsOfFile: frameImagePath) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: ScreenRatioUtility.imageWidth,
                        height: ScreenRatioUtility.imageHeight
                    )
                    .allowsHitTesting(false)
            }

            if isCountingDown {
                Text("\(countdown)")
                    .font(.system(size: 100.scaled, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 10.scaled)
            }

            VStack {

                Spacer()

                HStack(alignment: .center) {
                    Button(action: {
                        isCountingDown = true
                        countdown = 5

                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true)
                        { timer in
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
                    .disabled(isCountingDown || !camera.isSessionReady)

                    Button(action: {
                        camera.switchCamera()
                    }) {
                        Image("camerachange")
                            .resizable()
                            .frame(width: 40.scaled, height: 40.scaled)
                            .padding(.leading, 60.scaled)
                    }
                    .disabled(false)  // 명시적으로 사용자 상호작용 활성화
                    .allowsHitTesting(true)  // 터치 이벤트 허용
                }
            }
        }
        .onChange(of: camera.capturedImage) { oldValue, newImage in
            if let img = newImage {

                if let composedImage =
                    ImageComposer.composeFramedCapturedImage(
                        baseImage: img,
                        frameImageName: frameImagePath
                    )
                {
                    navModel.path.append(
                        AppRoute.result(IdentifiableImage(image: composedImage))
                    )
                } else {
                    navModel.path.append(
                        AppRoute.result(IdentifiableImage(image: img)))
                }
            }
        }
        .navigationBarHidden(true)
        .environmentObject(camera)
        .task {
            await camera.fetchCompletedCharacters()
        }
        .onAppear {
            camera.isPresentingCamera = true
            camera.configure()
        }
        .onDisappear {
            camera.isPresentingCamera = false
            camera.stopSession()
            camera.cameraError = nil
        }
        .alert(item: $camera.cameraError) { err in
            Alert(
                title: Text(LocalizedStringKey("camera_error_title")),
                message: Text(err.localizedDescription),
                dismissButton: .default(Text(LocalizedStringKey("close")))
            )
        }
        .onChange(of: camera.cameraError) { _, newValue in
            if newValue == nil,
               camera.isPresentingCamera
            {  // Alert가 dismiss 된 시점
                navModel.path.removeLast()
            }
        }
    }
}

#Preview {
    CameraView(frameImagePath: "frame_sea")
}
