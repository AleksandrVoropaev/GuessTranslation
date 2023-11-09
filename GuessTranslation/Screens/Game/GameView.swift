//
//  GameView.swift
//  GuessTranslation
//
//  Created by Oleksandr Voropayev on 08.11.2023.
//

import SwiftUI

struct GameView: View {
    // MARK: - PROPERTIES

    @ObservedObject private var viewModel = ViewModel()
    @State private var isAnimating: Bool = false
    @State private var isDialogPresented: Bool = false

    // MARK: - BODY

    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Correct attempts: \(viewModel.gameState.correct)")
                    Text("Wrong attempts: \(viewModel.gameState.wrong)")
                }
            }
            .padding(.bottom)

            if isAnimating {
                Spacer()
            }

            Text(viewModel.guessWord ?? "")
                .main()
                .multilineTextAlignment(.center)

            if !isAnimating {
                Spacer()
            }

            VStack {
                Text(viewModel.translation ?? "")
                    .secondary()
                    .multilineTextAlignment(.center)
                    .padding()

                HStack(alignment: .center) {
                    button(isCorrect: true)
                    button(isCorrect: false)
                }
            }
        }
        .padding(.horizontal)
        .onReceive(viewModel.$gameState) { _ in
            withAnimation(.linear(duration: 0)) {
                isAnimating = false
            }
        }
        .onReceive(viewModel.$guessWord) { _ in
            withAnimation(.linear(duration: Constants.duration)) {
                isAnimating = true
            }
        }
        .onReceive(viewModel.$isGameFinished) { isGameFinished in
            isDialogPresented = isGameFinished
        }
        .alert(isPresented: $isDialogPresented) {
            alert
        }
    }

    // MARK: - SUBVIEWS

    private func button(isCorrect: Bool) -> some View {
        Button {
            viewModel.didRecieve(answer: isCorrect)
        } label: {
            Text(isCorrect ? "Correct" : "Wrong")
                .secondary()
        }
        .foregroundColor(isCorrect ? .green : .red)
        .frame(width: 100)
    }

    private var alert: Alert {
        Alert(
            title: Text("Game Over"),
            message: Text("Your score is:\n" + viewModel.gameState.scoreString),
            dismissButton: .destructive(
                Text("Start new game"),
                action: {
                    viewModel.start()
                }
            )
        )
    }
}

// MARK: - PREVIEW

#Preview {
    GameView()
}
