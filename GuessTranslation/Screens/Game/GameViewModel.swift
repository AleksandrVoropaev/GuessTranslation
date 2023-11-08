//
//  GameViewModel.swift
//  GuessTranslation
//
//  Created by Oleksandr Voropayev on 08.11.2023.
//

import Foundation

extension GameView {
    final class ViewModel: ObservableObject {
        // MARK: - PROPERTIES

        private var words: [Word] = []
        private var currentWord: Word?

        @Published private(set) var word: String?
        @Published private(set) var translation: String?
        @Published private(set) var isGameFinished = false
        @Published private(set) var gameState: GameState = .initial

        // MARK: - INIT

        init() {
            loadWords()
        }

        // MARK: - PUBLIC FUNCTIONS

        func start() {
            resetGame()
        }

        func recieved(answer: Bool) {
            updateState(with: answer)
            nextStep()
        }

        func skip() {
            wrongAnswer()
            nextStep()
        }

        // MARK: - PRIVATE FUNCTIONS

        private func loadWords() {
            words = Word.mock
        }

        private func updateState(with answer: Bool) {
            isCorrect(answer) ? correctAnswer() : wrongAnswer()
        }

        private func isCorrect(_ answer: Bool) -> Bool {
            (currentWord?.english == translation) == answer
        }

        private func correctAnswer() {
            gameState.correct += 1
        }

        private func wrongAnswer() {
            gameState.wrong += 1
        }

        private func nextStep() {
            if checkIfFinished() {
                isGameFinished = true

                return
            }
            
            setNewWord()
        }

        private func checkIfFinished() -> Bool {
            gameState.all >= 15 || gameState.wrong >= 3
        }

        private func setNewWord() {
            guard let newWord = words.randomElement() else {
                return
            }

            currentWord = newWord
            word = newWord.spanish
            if shouldSetCorrectTranslation() {
                translation = newWord.english
            } else {
                let incorrectWord = words.filter { $0 != newWord }.randomElement() ?? newWord
                translation = incorrectWord.english
            }
        }

        private func shouldSetCorrectTranslation() -> Bool {
            Double(arc4random_uniform(UInt32.max) / UInt32.max) <= Constants.chance
        }

        private func resetGame() {
            isGameFinished = false
            gameState = .initial
        }
    }

    private enum Constants {
        static let chance: Double = 0.25
    }
}
