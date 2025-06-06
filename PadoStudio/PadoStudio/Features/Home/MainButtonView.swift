import SwiftUI

struct MainButtonView: View {
    let onCameraTapped: () -> Void
    let onGalleryTapped: () -> Void

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let buttonSize = max(width * 0.18, 90)
            let gallerySize = buttonSize * 0.7
            let bottomPadding = geometry.safeAreaInsets.bottom + 24
            let sidePadding = width * 0.05

            // ZStack에 명시적 프레임 설정
            ZStack {
                CameraButton(action: onCameraTapped, size: buttonSize)
                    .position(
                        x: width / 2,
                        y: height - buttonSize / 2 - bottomPadding
                    )
                
                GalleryButton(action: onGalleryTapped, size: gallerySize)
                    .position(
                        x: width - gallerySize / 2 - sidePadding,
                        y: height - gallerySize / 2 - bottomPadding
                    )
            }
            .frame(width: width, height: height) // 핵심!
        }
        .frame(maxHeight: .infinity) // 상위 뷰의 높이를 최대로 확장
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

// CameraButton과 GalleryButton 구조체는 기존 코드 유지

struct CameraButton: View {
    let action: () -> Void
    let size: CGFloat

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: "camera.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size * 0.35)
                    .foregroundColor(.white)
                Text("기록 남기기")
                    .font(.bodyBold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 4)
            }
            .frame(width: size, height: size)
            .padding(size * 0.05)
            .background(Circle().fill(Color.primaryGreen))
            .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 4)
        }
    }
}

struct GalleryButton: View {
    let action: () -> Void
    let size: CGFloat

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: "photo.on.rectangle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size * 0.4)
                    .foregroundColor(Color.primaryGreen)
                Text("갤러리")
                    .font(.caption1Bold)
                    .foregroundColor(Color.primaryGreen)
            }
            .frame(width: size, height: size)
            .background(
                Circle()
                    .fill(Color.white)
                    .overlay(
                        Circle().stroke(Color.primaryGreen, lineWidth: 3)
                    )
            )
            .shadow(color: .black.opacity(0.10), radius: 6, x: 0, y: 2)
        }
    }
}

#Preview {
    MainButtonView(
        onCameraTapped: {},
        onGalleryTapped: {}
    )
}
