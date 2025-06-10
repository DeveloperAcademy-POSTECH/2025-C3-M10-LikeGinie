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
    @EnvironmentObject var characterViewModel: CharacterViewModel
    @EnvironmentObject var frameViewModel: CharacterFrameViewModel
    
    // 선택된 프레임 이미지 이름
    private var frameImageName: String {
        return frameViewModel.selectedFrame.imgName
    }
    

    // CharacterViewModel에서 완성된 캐릭터들을 가져오되, 없으면 기본 캐릭터 사용
    private var completedCharacters: [[String]] {
        let characters = characterViewModel.getCompletedCharacters()
        // 캐릭터가 없으면 기본 캐릭터 반환
        return characters.isEmpty ? [["Asset5"]] : characters
    }
    
    // 프레임에 표시할 캐릭터들 - 각 캐릭터의 모든 파트를 ZStack으로 겹쳐서 표시
    private var characterViews: [AnyView] {
        return completedCharacters.enumerated().map { index, characterParts in
            let view = ZStack {
                // 캐릭터 파트들을 올바른 순서로 겹쳐서 표시
                ForEach(getSortedCharacterParts(characterParts), id: \.self) { partName in
                    Image(partName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .frame(width: min(150.scaled, (ScreenRatioUtility.imageWidth) / CGFloat(completedCharacters.count)),
                   height: min(150.scaled, (ScreenRatioUtility.imageWidth) / CGFloat(completedCharacters.count)))
            
            return AnyView(view)
        }
    }
    
    // 캐릭터 파트들을 올바른 레이어 순서로 정렬하는 함수
    private func getSortedCharacterParts(_ parts: [String]) -> [String] {
        // 파트 타입별 우선순서 정의 (뒤에서부터 앞으로 - 서핑보드가 가장 뒤, 악세사리가 가장 앞)
        let partOrder: [String] = ["board", "suit", "face", "hair", "accessory"]
        
        var sortedParts: [String] = []
        
        // 정의된 순서대로 파트 추가
        for partType in partOrder {
            for part in parts {
                if part.contains(partType) && !part.contains("empty") { // empty 파트는 제외
                    sortedParts.append(part)
                }
            }
        }
        
        // 순서에 없는 파트들도 추가 (혹시 모를 경우를 대비)
        for part in parts {
            if !sortedParts.contains(part) && !part.contains("empty") {
                sortedParts.append(part)
            }
        }
        
        return sortedParts
    }
    
    var body: some View {
        ZStack {
            CameraPreview(session: camera.session)
                .onAppear {
                    camera.configure()
                }
                .frame(width: ScreenRatioUtility.imageWidth , height: ScreenRatioUtility.imageHeight, alignment: .top )
                .cornerRadius(16.scaled)
                .clipped()
                

            Image(frameImageName)
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
                    ForEach(0..<characterViews.count, id: \.self) { index in
                        characterViews[index]
                    }
                }
                .frame(maxWidth: ScreenRatioUtility.imageWidth)
                .padding(.bottom, 30.scaled)
                
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
                    .disabled(false) // 명시적으로 사용자 상호작용 활성화
                    .allowsHitTesting(true) // 터치 이벤트 허용
                }
            }
        }
        .onChange(of: camera.capturedImage) { oldValue, newImage in
                  if let img = newImage {
                    
                      if let composedImage = ImageComposer.composeFramedImageWithCharacters(
                          baseImage: img,
                          frameImageName: frameImageName,
                          completedCharacters: completedCharacters
                      ) {
                          navModel.path.append(AppRoute.result(IdentifiableImage(image: composedImage)))
                      } else {
                          navModel.path.append(AppRoute.result(IdentifiableImage(image: img)))
                      }
                  }
              }
        .navigationBarHidden(true)
        .environmentObject(camera)
        .onAppear {
            print("CameraView - 완성된 캐릭터들: \(completedCharacters)")
            print("CameraView - CharacterViewModel 캐릭터 보유 여부: \(characterViewModel.hasCharacters())")
        }
    }
}

#Preview {
    CameraView()
        .environmentObject(CharacterViewModel())
        .environmentObject(CharacterFrameViewModel())
}
