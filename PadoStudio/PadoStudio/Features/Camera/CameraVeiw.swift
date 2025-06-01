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
      @State private var showResult = false
      @State private var countdown = 5
      @State private var isCountingDown = false

    var body: some View {
        NavigationView {
            ZStack {
                CameraPreview(session: camera.session)
                    .onAppear {
                        camera.configure()
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 4 / 3)
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
                        .font(.largeTitle)
                        .padding(.bottom, 20)
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
                            Image(systemName: "camera.circle.fill")
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
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .resizable()
                                .frame(width: 40, height: 30)
                                .padding(.leading, 60)
                        }
                        
                    }
                }
                
                NavigationLink(
                                  destination: CameraStageView(image: camera.capturedImage, onRetake: {
                                      camera.capturedImage = nil
                                      showResult = false
                                  }),
                                  isActive: $showResult
                              ) {
                    EmptyView()
                }
            }
            .onChange(of: camera.capturedImage) { newImage in
                if newImage != nil {
                    showResult = true
                }
            }
        }
    }
}

#Preview {
    CameraView()
}
