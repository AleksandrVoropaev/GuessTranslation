//
//  GameModelTests.swift
//  GuessTranslationTests
//
//  Created by Oleksandr Voropayev on 09.11.2023.
//

import XCTest
@testable import GuessTranslation

final class GameModelTests: XCTestCase {
    private let probability: Double = 0.25
    private var model: GameModel!

    override func setUp() {
        super.setUp()

        model = GuessGameModel(correctWordProbability: probability)
    }

    override func tearDown() {
        super.tearDown()

        model = nil
    }

    func testCorrectWordCorrectAnswer() throws {
        let word = try XCTUnwrap(Word.mock.first)

        XCTAssertTrue(model.checkAnswer(word: word, answer: true))
    }

    func testCorrectWordIncorrectAnswer() throws {
        let word = try XCTUnwrap(Word.mock.first)

        XCTAssertFalse(model.checkAnswer(word: word, answer: false))
    }

    func testIncorrectWordCorrectAnswer() throws {
        let word = Word(english: "1234", spanish: try XCTUnwrap(Word.mock.first).spanish)

        XCTAssertTrue(model.checkAnswer(word: word, answer: false))
    }

    func testIncorrectWordIncorrectAnswer() throws {
        let word = Word(english: "1234", spanish: try XCTUnwrap(Word.mock.first).spanish)

        XCTAssertFalse(model.checkAnswer(word: word, answer: true))
    }

    func testProbability() {
        let (correct, incorrect) = (0..<1000).reduce(into: (correct: 0, incorrect: 0)) { partialResult, _ in
            if model.checkAnswer(word: model.next(), answer: true) {
                partialResult.correct += 1
            } else {
                partialResult.incorrect += 1
            }
        }

        XCTAssertEqual(Double(correct) / Double(correct + incorrect), probability, accuracy: 0.05)
    }
}
