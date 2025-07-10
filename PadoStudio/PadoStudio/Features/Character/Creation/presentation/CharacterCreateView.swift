//
//  CharacterCreateView.swift
//  PadoStudio
//
//  Created by eunsong on 5/31/25.
//

import SwiftUI

struct CharacterCreateView: View {
    let number: Int
    @StateObject var viewModel = CharacterViewModel()
    @State private var showBackAlert = false
    @EnvironmentObject var navModel: NavigationViewModel

    var body: some View {
        ZStack {
            GeometryReader { proxy in
                backgroundView(proxy: proxy)
                contentView(proxy: proxy)
            }
        }
        .ignoresSafeArea()
        .onAppear(perform: initialize)
        .alert("character_reset_alert_title", isPresented: $showBackAlert) {
            backAlertButtons
        } message: {
            Text("character_reset_alert_message")
        }
    }

    // MARK: - Subviews

    private func backgroundView(proxy: GeometryProxy) -> some View {
        let width = proxy.size.width
        let height = proxy.size.height
        return Image("bg_character_creation")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: max(width, 1), height: max(height, 1))
            .position(x: width / 2, y: height / 2)
    }

    private func contentView(proxy: GeometryProxy) -> some View {
        VStack {
            ToolbarView(title: "character_create_title", titleColor: .white) {
                showBackAlert = true
            }
                    .safeAreaInset(edge: .top) {
                        Color.clear.frame(height: 48.scaled)
                    }

            CharacterPreviewPager(
                number: number,
                currentIndex: $viewModel.currentIndex,
                viewModel: viewModel,
                proxy: proxy
            )

            CharacterSelectionSection(
                proxy: proxy,
                number: number,
                viewModel: viewModel
            )
        }
    }

    private var backAlertButtons: some View {
        Group {
            Button("cancel_button_label", role: .cancel) {}
            Button("edit_count_button_label", role: .destructive) {
                navModel.path.removeLast()
            }
        }
    }

    private func initialize() {
        Task {
            await viewModel.resetCharacterCreationSession()
            viewModel.initializeDefaultSelections(count: number)
        }
    }
}

// MARK: - CharacterSelectionSection

struct CharacterSelectionSection: View {
    let proxy: GeometryProxy
    let number: Int
    @ObservedObject var viewModel: CharacterViewModel
    
    var body: some View {
        VStack {
            CharacterPartSelector(viewModel: viewModel, proxy: proxy)
            CharacterAssetGrid(
                proxy: proxy,
                viewModel: viewModel,
                currentIndex: viewModel.currentIndex
            )
            ActionButtonPanel(
                proxy: proxy,
                number: number,
                viewModel: viewModel
            )
        }
        .padding(.horizontal, proxy.size.width * 0.04)
        .padding(.bottom, proxy.safeAreaInsets.bottom + 24)
        .padding(.top, proxy.size.width * 0.04)
        .background(TopRoundedShadowBackground())
    }
}

// MARK: - ActionButtonPanel

struct ActionButtonPanel: View {
    let proxy: GeometryProxy
    let number: Int
    @ObservedObject var viewModel: CharacterViewModel
    @EnvironmentObject var navModel: NavigationViewModel

    var body: some View {
        HStack(spacing: 12.scaled) {
            resetButton
            Spacer()
            primaryActionButton
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 8.scaled)
    }

    private var resetButton: some View {
        CharacterActionButton(
            title: "reset_button_label",
            foreground: .gray09,
            background: .gray04,
            font: .title3RegularResponsive(size: 13, proxy: proxy),
            width: proxy.size.width * 0.4,
            height: proxy.size.height * 0.06
        ) {
            viewModel.resetCharacter()
            viewModel.resetPage()
        }
    }

    @ViewBuilder
    private var primaryActionButton: some View {
        if viewModel.currentIndex < number - 1 {
            CharacterActionButton(
                title: "next_button_label",
                foreground: .white,
                background: .primaryGreen,
                font: .title3RegularResponsive(size: 13, proxy: proxy),
                width: proxy.size.width * 0.4,
                height: proxy.size.height * 0.06
            ) {
                viewModel.nextPage(count: number)
            }
        } else {
            CharacterActionButton(
                title: "save_button_label",
                foreground: .white,
                background: .primaryGreen,
                font: .title3RegularResponsive(size: 13, proxy: proxy),
                width: proxy.size.width * 0.4,
                height: proxy.size.height * 0.06
            ) {
                viewModel.saveAllCharacterSnapshots(
                    count: number,
                    imageSize: proxy.size
                ) {
                    navModel.path.append(AppRoute.characterCheck)
                }
            }
        }
    }
}

// MARK: - CharacterActionButton

struct CharacterActionButton: View {
    let title: String
    let foreground: Color
    let background: Color
    let font: Font
    let width: CGFloat
    let height: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(LocalizedStringKey(title))
                .font(font)
                .foregroundColor(foreground)
                .padding(.vertical, height * 0.25)
                .padding(.horizontal, width * 0.1)
                .frame(minWidth: width, minHeight: height)
                .background(background)
                .cornerRadius(15)
        }
    }
}

#Preview("CharacterCreateView") {
    CharacterCreateView(number: 3)
        .environmentObject(NavigationViewModel())
}
