//
//  CameraStageView.swift
//  PadoStudio
//
//  Created by kim yijun on 5/29/25.
//

import SwiftData
import SwiftUI

struct CameraStageView: View {
    let image: UIImage?
    var onRetake: () -> Void
    @EnvironmentObject var navModel: NavigationViewModel
    @Environment(\.modelContext) var modelContext

    var body: some View {
        ZStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: ScreenRatioUtility.imageWidth,
                        height: ScreenRatioUtility.imageHeight)
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
                        print("이미지 저장")
                        insertImageData(image: finalImage)

                        print("이미지체크뷰로 이동")
                        let identifiableImage = IdentifiableImage(
                            image: finalImage)
                        navModel.path.append(
                            AppRoute.ImageCheck(identifiableImage))
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
        }
    }

    func savePhotoForGallery(image: UIImage) throws -> URL {
        guard let data = image.pngData() else {
            throw NSError(
                domain: "SaveImageError", code: 1,
                userInfo: [NSLocalizedDescriptionKey: "이미지를 Data로 변환할 수 없음"])
        }

        guard
            let directory = FileManager.default.urls(
                for: .documentDirectory, in: .userDomainMask
            ).first
        else {
            throw NSError(
                domain: "SaveImageError", code: 2,
                userInfo: [NSLocalizedDescriptionKey: "문서 디렉토리를 찾을 수 없음"])
        }
        let fileName = UUID().uuidString + ".png"
        let fileURL = directory.appendingPathComponent(fileName)

        do {
            try data.write(to: fileURL)
        } catch {
            print("저장 실패!")
        }

        return fileURL
    }

    func insertImageData(image: UIImage) {
        do {
            let fileURL = try savePhotoForGallery(image: image)
            let newImageModel = GalleryData(filePath: fileURL.path)
            modelContext.insert(newImageModel)
        } catch {
            print("에러 발생")
        }
    }
}

#Preview {
    let dummyImage = UIImage(systemName: "frame-sea")
    let dummyNavModel = NavigationViewModel()

    return CameraStageView(image: dummyImage, onRetake: {})
        .environmentObject(dummyNavModel)
}
