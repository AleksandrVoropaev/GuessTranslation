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

        private var timer: Timer?
        
        // MARK: - INIT

        init() {
            loadWords()
            start()
        }

        // MARK: - PUBLIC FUNCTIONS

        func start() {
            resetGame()
            nextStep()
        }

        func recieved(answer: Bool) {
            let isCorrect = isCorrect(answer)
            proceed { [weak self] in
                self?.updateState(isCorrectAnswer: isCorrect)
            }
        }

        func skip() {
            proceed { [weak self] in
                self?.updateState(isCorrectAnswer: false)
            }
        }

        // MARK: - PRIVATE FUNCTIONS

        private func loadWords() {
            words = Word.mock
        }

        private func proceed(with block: @escaping ()->()) {
            stopTimer()
            block()
            nextStep()
        }

        private func isCorrect(_ answer: Bool) -> Bool {
            (currentWord?.english == translation) == answer
        }

        private func updateState(isCorrectAnswer: Bool) {
            isCorrectAnswer ? correctAnswer() : wrongAnswer()
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
            startTimer()
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
            Double(arc4random()) / Double(UInt32.max) <= Constants.chance
        }

        private func resetGame() {
            isGameFinished = false
            gameState = .initial
        }

        private func startTimer() {
            timer = Timer.scheduledTimer(withTimeInterval: Constants.duration, repeats: false) { [weak self] _ in
                self?.skip()
            }
        }

        private func stopTimer() {
            timer?.invalidate()
            timer = nil
        }
    }

    enum Constants {
        static let chance: Double = 0.25
        static let duration: Double = 3
    }
}
