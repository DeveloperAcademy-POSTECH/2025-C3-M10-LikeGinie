import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navModel: NavigationViewModel
    
    var body: some View {
        GeometryReader { proxy in
            let isPad = proxy.size.width > 700
            let topPadding = isPad ? proxy.size.height * 0.06 : proxy.size.height * 0.09
            let carouselHeight = isPad ? proxy.size.height * 0.28 : proxy.size.height * 0.22
            let carouselBottomPadding = isPad ? proxy.size.height * 0.04 : proxy.size.height * 0.03
            let carouselTopPadding = isPad ? proxy.size.height * 0.08 : proxy.size.height * 0.30 // 원하는 만큼 조정
            let buttonBottomPadding = isPad ? 40.0 : 20.0
            
            
            ZStack() {
                Image("bg_home")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            }
            VStack {
                MainTextView(proxy: proxy)
                    .padding(.top, topPadding)
                    .padding(.horizontal, isPad ? 100 : 50)
            }
            
            Spacer().frame(height: isPad ? 30 : 16)
            
            VStack {
                InfiniteCarouselView(images: ImageDataService.fetchImages())
                    .frame(height: carouselHeight)
                    .padding(.top, carouselTopPadding)
                    .padding(.bottom, carouselBottomPadding)
            }
            
            Spacer().frame(height: isPad ? 30 : 16)
            
            VStack {
                Spacer()
                MainButtonView(
                    onCameraTapped: { navModel.navigate(to: .startRecording) },
                    onGalleryTapped: { navModel.navigate(to: .gallery) }
                )
                .padding(.bottom, isPad ? 40 : 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
}
#Preview {
    HomeView().environmentObject(NavigationViewModel())
}
