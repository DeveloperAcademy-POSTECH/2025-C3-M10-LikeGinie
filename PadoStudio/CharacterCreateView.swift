struct CharacterCreateView: View {
    @StateObject var viewModel = CharacterViewModel()

    var body: some View {
        VStack {
            // 캐릭터 미리보기
            ZStack {
                ForEach(CharacterPartType.allCases, id: \.self) { part in
                    if let name = viewModel.getPreview(for: part) {
                        Image(name)
                            .resizable()
                            .scaledToFit()
                    }
                }
            }

            // 하단: 선택 가능한 썸네일 목록
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.assets.filter { $0.part == .hair }) { asset in
                        Image(asset.imageName)
                            .resizable()
                            .frame(width: 60, height: 60)
                            .onTapGesture {
                                viewModel.select(asset: asset)
                            }
                    }
                }
            }
        }
    }
}