import SwiftUI

struct CharacterCountSelectView: View {
    @EnvironmentObject var navModel: NavigationViewModel
    @State private var number = 0
    @State private var showAlert = false

    var body: some View {
        ZStack(alignment: .top) { // 상단 정렬
            // 1. 배경 이미지
            Image("background2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Spacer()
            Spacer()

            // 2. 상단 툴바 (항상 배경 위, 화면 상단에 고정)
            ToolbarView(title: "캐릭터 만들기", titleColor: .black)

            // 3. 메인 콘텐츠
            VStack {
                Spacer().frame(height: 80) // 툴바 높이만큼 여백
                VStack(spacing: 4) {
                    Text("몇 명의 캐릭터를 만들까요?")
                        .font(.eliceBold(size: 25))
                        .multilineTextAlignment(.center)
                    Text("최대 6명까지 가능해요!")
                        .font(.styledRegular(size: 15))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)

                HStack(spacing: 20) {
                    Button(action: { if number > 0 { number -= 1 } }) {
                        ZStack {
                            Circle()
                                .stroke(number > 0 ? Color.primaryGreen : Color.gray04, lineWidth: 2)
                                .foregroundColor(.gray01)
                                .frame(width: 20, height: 20)
                            Image(systemName: "minus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 10)
                                .foregroundColor(number > 0 ? Color.primaryGreen : Color.gray04)
                        }
                    }
                    .disabled(number <= 0)

                    Text("\(number)")
                        .font(.eliceBold(size: 70))
                        .frame(minWidth: 60)

                    Button(action: { if number < 6 { number += 1 } }) {
                        ZStack {
                            Circle()
                                .stroke(number < 6 ? Color.primaryGreen : Color.gray04, lineWidth: 2)
                                .foregroundColor(.gray01)
                                .frame(width: 20, height: 20)
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 10)
                                .foregroundColor(number < 6 ? Color.primaryGreen : Color.gray04)
                        }
                    }
                    .disabled(number >= 6)
                }

                Spacer()
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)

            // 하단 버튼
            VStack {
                Spacer()
                SquareButton(color: .green, label: "설정하기") {
                    if number > 0 {
                        navModel.navigate(to: .characterCreate(number: number))
                    } else {
                        showAlert = true
                    }
                }
            }
        }
        .alert("캐릭터를 한 명 이상 선택해주세요!", isPresented: $showAlert) {
            Button("확인", role: .cancel) {}
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CharacterCountSelectView()
}
