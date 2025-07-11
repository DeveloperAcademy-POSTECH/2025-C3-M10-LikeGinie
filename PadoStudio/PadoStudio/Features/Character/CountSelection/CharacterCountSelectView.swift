import SwiftUI

struct CharacterCountSelectView: View {
    @EnvironmentObject var navModel: NavigationViewModel
    @State private var number = 1
    @Environment(\.horizontalSizeClass) private var sizeClass

    var body: some View {
        if sizeClass == .regular {
            CharacterCountSelectPadLayout(
                navModel: navModel,
                number: $number

            )
        } else {
            CharacterCountSelectPhoneLayout(
                navModel: navModel,
                number: $number

            )
        }
    }
}

//아이폰용
struct CharacterCountSelectPhoneLayout: View {
    @ObservedObject var navModel: NavigationViewModel
    @Binding var number: Int

    var body: some View {
        ZStack(alignment: .top) {
            Image("background2")
                .resizable()
                .ignoresSafeArea()

            VStack {
                ToolbarView(title: "character_count_select_title", titleColor: .black)
                    .safeAreaInset(edge: .top) {
                        Color.clear.frame(height: 48)
                    }

                Spacer()

                VStack(spacing: 20) {
                    VStack(spacing: 4) {
                        Text("character_count_question")
                            .font(.eliceBold(size: 25))
                            .multilineTextAlignment(.center)
                        Text("character_count_info")
                            .font(.styledRegular(size: 15))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }

                    HStack(spacing: 20) {
                        minusButton
                        Text("\(number)")
                            .font(.eliceBold(size: 70))
                            .frame(minWidth: 60)
                        plusButton
                    }
                }

                Spacer()

                SquareButton(color: .green, label: "set_button_label") {
                    if number >= 1 {
                        navModel.navigate(
                            to: .characterCreate(number: number)
                        )
                    }
                }
                .padding(.bottom, 30)

            }
            .padding(.horizontal, 20)
            .navigationBarTitleDisplayMode(.inline)
        }
        .ignoresSafeArea()

    }

    private var minusButton: some View {
        Button(action: { if number > 1 { number -= 1 } }) {
            ZStack {
                Circle()
                    .stroke(
                        number > 1 ? Color.primaryGreen : Color.gray04,
                        lineWidth: 2
                    )
                    .foregroundColor(.gray01)
                    .frame(width: 20, height: 20)
                Image(systemName: "minus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 10)
                    .foregroundColor(
                        number > 1 ? Color.primaryGreen : Color.gray04
                    )
            }
        }
        .disabled(number <= 1)
    }

    private var plusButton: some View {
        Button(action: { if number < 6 { number += 1 } }) {
            ZStack {
                Circle()
                    .stroke(
                        number < 6 ? Color.primaryGreen : Color.gray04,
                        lineWidth: 2
                    )
                    .foregroundColor(.gray01)
                    .frame(width: 20, height: 20)
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 10)
                    .foregroundColor(
                        number < 6 ? Color.primaryGreen : Color.gray04
                    )
            }
        }
        .disabled(number >= 6)
    }
}

// 아이패드용
struct CharacterCountSelectPadLayout: View {
    @ObservedObject var navModel: NavigationViewModel
    @Binding var number: Int

    var body: some View {
        ZStack(alignment: .top) {
            Image("background2")
                .resizable()
                .ignoresSafeArea()
            //
            VStack {
                ToolbarView(title: "character_count_select_title", titleColor: .black)
                    .safeAreaInset(edge: .top) {
                        Color.clear.frame(height: 48)
                    }

                Spacer()

                VStack(spacing: 20) {
                    VStack(spacing: 4) {
                        Text("character_count_question")
                            .font(.eliceBold(size: 40))
                            .multilineTextAlignment(.center)
                        Text("character_count_info")
                            .font(.styledRegular(size: 24))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }

                    HStack(spacing: 40) {
                        minusButton
                        Text("\(number)")
                            .font(.eliceBold(size: 120))
                            .frame(minWidth: 100)
                        plusButton
                    }
                }

                Spacer()

                SquareButton(color: .green, label: "set_button_label") {
                    if number >= 1 {
                        navModel.navigate(
                            to: .characterCreate(number: number)
                        )
                    }
                }

            }
            .padding(.horizontal, 20)
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar(.hidden, for: .navigationBar)
        .ignoresSafeArea()

    }

    private var minusButton: some View {
        Button(action: { if number > 1 { number -= 1 } }) {
            ZStack {
                Circle()
                    .stroke(
                        number > 1 ? Color.primaryGreen : Color.gray04,
                        lineWidth: 4
                    )
                    .foregroundColor(.gray01)
                    .frame(width: 40, height: 40)
                Image(systemName: "minus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(
                        number > 1 ? Color.primaryGreen : Color.gray04
                    )
            }
        }
        .disabled(number <= 1)
    }

    private var plusButton: some View {
        Button(action: { if number < 6 { number += 1 } }) {
            ZStack {
                Circle()
                    .stroke(
                        number < 6 ? Color.primaryGreen : Color.gray04,
                        lineWidth: 4
                    )
                    .foregroundColor(.gray01)
                    .frame(width: 40, height: 40)
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(
                        number < 6 ? Color.primaryGreen : Color.gray04
                    )
            }
        }
        .disabled(number >= 6)
    }
}

#Preview {
    CharacterCountSelectView()
        .environmentObject(NavigationViewModel())
}
