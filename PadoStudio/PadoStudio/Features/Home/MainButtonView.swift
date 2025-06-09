import SwiftUI

struct MainButtonView: View {
    let onCameraTapped: () -> Void
    let onGalleryTapped: () -> Void

    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        if sizeClass == .regular {
            // iPad 등 넓은 화면용
            PadButtonLayout(
                onCameraTapped: onCameraTapped,
                onGalleryTapped: onGalleryTapped
            )
        } else {
            // iPhone 등 좁은 화면용
            PhoneButtonLayout(
                onCameraTapped: onCameraTapped,
                onGalleryTapped: onGalleryTapped
            )
        }
    }
}
// 아이폰용 레이아웃
struct PhoneButtonLayout: View {
    let onCameraTapped: () -> Void
    let onGalleryTapped: () -> Void

    var body: some View {
        Color.clear
            // 중앙 하단: 기록 남기기(카메라)
            .overlay(
                CameraButton(action: onCameraTapped, size: 100)
                    .padding(.bottom, 30),
                alignment: .bottom
            )
            // 오른쪽 하단: 갤러리
            .overlay(
                GalleryButton(action: onGalleryTapped, size: 80)
                    .padding(.bottom, 30)
                    .padding(.trailing, 24),
                alignment: .bottomTrailing
            )
            .ignoresSafeArea(.container, edges: .bottom)
    }
}

// 아이패드용 레이아웃 (더 크고 넓게)
struct PadButtonLayout: View {
    let onCameraTapped: () -> Void
    let onGalleryTapped: () -> Void

    var body: some View {
        Color.clear
            // 중앙 하단: 기록 남기기(카메라)
            .overlay(
                CameraButton(action: onCameraTapped, size: 140)
                    .padding(.bottom, 60),
                alignment: .bottom // 중앙 하단 정렬
            )
            // 오른쪽 하단: 갤러리
            .overlay(
                GalleryButton(action: onGalleryTapped, size: 100)
                    .padding(.bottom, 60)
                    .padding(.trailing, 130),
                alignment: .bottomTrailing // 오른쪽 하단 정렬
            )
            .ignoresSafeArea(.container, edges: .bottom)
    }
}


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
