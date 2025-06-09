import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navModel: NavigationViewModel
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        if sizeClass == .regular {
            HomePadLayout()  // 파라미터 제거
                .environmentObject(navModel)
        } else {
            HomePhoneLayout()
                .environmentObject(navModel)
        }
    }
}

struct HomePadLayout: View {
    @EnvironmentObject var navModel: NavigationViewModel

    var body: some View {
        GeometryReader { proxy in
            let topPadding = proxy.size.height * 0.002  // 더 작은 값으로 조정
            let carouselHeight = proxy.size.height * 0.28
            let carouselBottomPadding = proxy.size.height * 0.04
            let buttonBottomPadding: CGFloat = 40.0

            ZStack {
                Image("bg_home")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    // 상단 텍스트
                    MainTextView(proxy: proxy)  // 내부 GeometryReader의 proxy 사용
                        .padding(.top, proxy.size.height * 0.08)
                        .padding(.horizontal, 100)

                    Spacer().frame(height: proxy.size.height * 0.18)

                    // 캐러셀
                    InfiniteCarouselView(images: ImageDataService.fetchImages())
                        .frame(height: 300)

                    Spacer()

                    MainButtonView(
                        onCameraTapped: {
                            navModel.navigate(to: .startRecording)
                        },
                        onGalleryTapped: { navModel.navigate(to: .gallery) }
                    )
                    .padding(.bottom, buttonBottomPadding)
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .top
                )
            }
        }
    }
}

struct HomePhoneLayout: View {
    @EnvironmentObject var navModel: NavigationViewModel

    var body: some View {
        GeometryReader { proxy in
            let topPadding = proxy.size.height * 0.08
            let carouselHeight = proxy.size.height * 0.22
            let buttonBottomPadding: CGFloat = 30.0
            //            let isWide = proxy.size.width > 400
            //            let spacing = isWide ? proxy.size.width * 0.06 : proxy.size.width * 0.03
            let getCenter = (proxy.size.width * 0.5)
            ZStack {
                // 배경 이미지
                Image("bg_home")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()

                // 본문 콘텐츠
                VStack(spacing: 0) {
                    MainTextView(proxy: proxy)
                        .padding(.top, topPadding)
                        .padding(.horizontal, 50)

                    Spacer().frame(height: proxy.size.height * 0.18)

                    InfiniteCarouselView(images: ImageDataService.fetchImages())
                        .frame(height: 150)

                    Spacer()

                    MainButtonView(
                        onCameraTapped: {
                            navModel.navigate(to: .startRecording)
                        },
                        onGalleryTapped: { navModel.navigate(to: .gallery) }
                    )
                    .padding(.bottom, buttonBottomPadding)

                }.frame(width: proxy.size.width)
            }.frame(width: proxy.size.width)
        }
    }
}
#Preview {
    HomeView().environmentObject(NavigationViewModel())
}
