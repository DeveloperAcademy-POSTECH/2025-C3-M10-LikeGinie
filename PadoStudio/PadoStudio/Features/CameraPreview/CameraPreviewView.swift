import SwiftData
import SwiftUI

struct CameraPreviewView: View {
    let image: UIImage?
    var onRetake: () -> Void
    @EnvironmentObject var navModel: NavigationViewModel
    @StateObject private var viewModel = CameraPreviewViewModel()

    var body: some View {
        ZStack {
            Group {
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
            }

            VStack {
                Spacer()
                ZStack {
                    downloadButton
                    HStack {
                        retakeButton
                        Spacer()
                    }
                }
                .padding(.bottom, 30.scaled)
            }
        }
    }

    private var downloadButton: some View {
        Button(action: {
            guard let finalImage = image else {
                print("최종 이미지가 없음")
                return
            }

            viewModel.saveImageToGallery(
                image: finalImage,
                onSuccess: { path in
                    print("이미지 저장 성공: \(path)")
                    let identifiableImage = IdentifiableImage(image: finalImage)
                    navModel.path.append(AppRoute.ImageCheck(identifiableImage))
                },
                onFailure: { error in
                    print("이미지 저장 실패: \(error.localizedDescription)")
                    // TODO: 사용자에게 Alert 등으로 알릴 수 있음
                }
            )
        }) {
            Image("download")
                .resizable()
                .frame(width: 70.scaled, height: 70.scaled)
        }
    }

    private var retakeButton: some View {
        Button(action: {
            print("재촬영 눌림!")
            onRetake()
        }) {
            Image("cameraagain")
                .resizable()
                .frame(width: 40.scaled, height: 40.scaled)
        }
        .padding(.leading, 30.scaled)
    }
}

#Preview {
    let dummyImage = UIImage(systemName: "frame-sea")
    let dummyNavModel = NavigationViewModel()

    CameraPreviewView(image: dummyImage, onRetake: {})
        .environmentObject(dummyNavModel)
}
