//
//  Game.swift
//  GuessTranslation
//
//  Created by Oleksandr Voropayev on 09.11.2023.
//

import Foundation

protocol GameModel {
    func next() -> Word
    func checkAnswer(word: Word, answer: Bool) -> Bool
}

final class GuessGameModel: GameModel {
    // MARK: - PROPERTIES

    private var correctWordProbability: Double
    private var words: [Word] = []

    // MARK: - INIT

    init(correctWordProbability: Double) {
        self.correctWordProbability = correctWordProbability
        self.loadWords()
    }

    // MARK: - PUBLIC FUNCTIONS

    func checkAnswer(word: Word, answer: Bool) -> Bool {
        guard let correctTranslation = words.first(where: { $0.spanish == word.spanish }) else {
            return false
        }

        return (word.english == correctTranslation.english) == answer
    }

    func next() -> Word {
        guard let word = words.randomElement() else {
            return .empty
        }

        if shouldProvideCorrectTranslation() {
            return word
        } else {
            let incorrectWord = words.filter { $0 != word }.randomElement() ?? word

            return Word(english: word.english, spanish: incorrectWord.spanish)
        }
    }

    // MARK: - PRIVATE FUNCTIONS

    private func loadWords() {
        words = Word.mock
    }

    private func shouldProvideCorrectTranslation() -> Bool {
        Double(arc4random()) / Double(UInt32.max) <= correctWordProbability
    }
}

private extension Word {
    static var empty: Self {
        .init(english: "", spanish: "")
    }
}
