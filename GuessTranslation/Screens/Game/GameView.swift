//
//  GameView.swift
//  GuessTranslation
//
//  Created by Oleksandr Voropayev on 08.11.2023.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel = ViewModel()
    @State private var isAnimating: Bool = false

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

            Text(viewModel.word ?? "")
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
        .onReceive(viewModel.$word) { _ in
            withAnimation(.linear(duration: Constants.duration)) {
                isAnimating = true
            }
        }
    }

    private func button(isCorrect: Bool) -> some View {
        Button {
            viewModel.recieved(answer: isCorrect)
        } label: {
            Text(isCorrect ? "Correct" : "Wrong")
                .secondary()
        }
        .foregroundColor(isCorrect ? .green : .red)
        .frame(width: 100)
    }
}

#Preview {
    GameView()
}
