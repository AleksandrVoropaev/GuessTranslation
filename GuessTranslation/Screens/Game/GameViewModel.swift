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

        private let gameModel: GameModel
        private var currentWord: Word?
        private var timer: Timer?

        @Published private(set) var guessWord: String?
        @Published private(set) var translation: String?
        @Published private(set) var isGameFinished = false
        @Published private(set) var gameState: GameState = .initial

        // MARK: - INIT

        init(gameModel: GameModel = GuessGameModel(correctWordProbability: Constants.probability)) {
            self.gameModel = gameModel
            self.start()
        }

        // MARK: - PUBLIC FUNCTIONS

        func start() {
            resetGame()
            nextStep()
        }

        func didRecieve(answer: Bool) {
            guard let currentWord else { return }

            let isCorrect = gameModel.checkAnswer(word: currentWord, answer: answer)
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

        private func proceed(with block: @escaping ()->()) {
            stopTimer()
            block()
            nextStep()
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
            
            setNextWord()
            startTimer()
        }

        private func checkIfFinished() -> Bool {
            gameState.all >= Constants.maxTotalAnswers || gameState.wrong >= Constants.maxWrongAnswers
        }

        private func setNextWord() {
            let nextWord = gameModel.next()

            currentWord = nextWord
            guessWord = nextWord.spanish
            translation = nextWord.english
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
        static let probability: Double = 0.25
        static let duration: Double = 3
        static let maxTotalAnswers = 15
        static let maxWrongAnswers = 3
    }
}
