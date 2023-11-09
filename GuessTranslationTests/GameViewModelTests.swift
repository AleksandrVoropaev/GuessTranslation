//
//  GameViewModelTests.swift
//  GuessTranslationTests
//
//  Created by Oleksandr Voropayev on 09.11.2023.
//

import XCTest
@testable import GuessTranslation

final class GameViewModelTests: XCTestCase {
    private typealias ViewModel = GameView.ViewModel
    private typealias Constants = GameView.Constants

    private var word: Word!
    private var model: MockedGameModel!
    private var viewModel: ViewModel!

    override func setUp() {
        super.setUp()

        word = Word(english: "english", spanish: "spanish")
        model = MockedGameModel(isCorrectAnswer: true, word: word)
        viewModel = ViewModel(gameModel: model)
    }

    override func tearDown() {
        super.tearDown()

        word = nil
        model = nil
        viewModel = nil
    }

    func testInitialState() throws {
        XCTAssertEqual(viewModel.guessWord, word.spanish)
        XCTAssertEqual(viewModel.translation, word.english)
        XCTAssertFalse(viewModel.isGameFinished)
        XCTAssertEqual(viewModel.gameState, .initial)
    }

    func testDidReceiveAnswer() {
        let guessWord = "word"
        let translation = "palabra"
        model.word = Word(english: translation, spanish: guessWord)

        XCTAssertEqual(viewModel.guessWord, word.spanish)
        XCTAssertEqual(viewModel.translation, word.english)

        viewModel.didRecieve(answer: true)

        XCTAssertEqual(viewModel.guessWord, guessWord)
        XCTAssertEqual(viewModel.translation, translation)
    }

    func testDidReceiveCorrectAnswer() {
        viewModel.didRecieve(answer: true)
        
        XCTAssertEqual(viewModel.gameState.correct, 1)
        XCTAssertEqual(viewModel.gameState.wrong, 0)
    }

    func testDidReceiveIncorrectAnswer() {
        model.isCorrectAnswer = false
        viewModel.didRecieve(answer: true)

        XCTAssertEqual(viewModel.gameState.correct, 0)
        XCTAssertEqual(viewModel.gameState.wrong, 1)
    }

    func testDidntReceiveAnswer() {
        model.isCorrectAnswer = true

        _ = XCTWaiter.wait(
            for: [expectation(description: "Wait for timer")],
            timeout: Constants.duration
        )

        XCTAssertEqual(viewModel.gameState.correct, 0)
        XCTAssertEqual(viewModel.gameState.wrong, 1)
    }

    func testWaitAndRecieveAnswer() {
        model.isCorrectAnswer = true

        _ = XCTWaiter.wait(
            for: [expectation(description: "Wait for timer")],
            timeout: Constants.duration - 0.1
        )

        viewModel.didRecieve(answer: true)

        XCTAssertEqual(viewModel.gameState.correct, 1)
        XCTAssertEqual(viewModel.gameState.wrong, 0)
    }

    func testMaxTotalAnswersGameFinished() {
        model.isCorrectAnswer = true

        XCTAssertFalse(viewModel.isGameFinished)

        (0..<Constants.maxTotalAnswers).forEach { _ in
            viewModel.didRecieve(answer: true)
        }

        XCTAssertTrue(viewModel.isGameFinished)
    }

    func testMaxWrongAnswersGameFinished() {
        model.isCorrectAnswer = false

        XCTAssertFalse(viewModel.isGameFinished)

        (0..<Constants.maxWrongAnswers).forEach { _ in
            viewModel.didRecieve(answer: true)
        }

        XCTAssertTrue(viewModel.isGameFinished)
    }

    func testRestart() {
        model.isCorrectAnswer = false
        (0..<Constants.maxWrongAnswers).forEach { _ in
            viewModel.didRecieve(answer: true)
        }

        XCTAssertTrue(viewModel.isGameFinished)

        viewModel.start()

        XCTAssertFalse(viewModel.isGameFinished)
        XCTAssertEqual(viewModel.gameState, .initial)
    }

    func testMaxSkipGameFinished() {
        model.isCorrectAnswer = false

        XCTAssertFalse(viewModel.isGameFinished)

        _ = XCTWaiter.wait(
            for: [expectation(description: "Wait for timer")],
            timeout: Constants.duration * Double(Constants.maxWrongAnswers)
        )

        XCTAssertTrue(viewModel.isGameFinished)
    }
}

private final class MockedGameModel: GameModel {
    var isCorrectAnswer: Bool
    var word: Word

    init(isCorrectAnswer: Bool, word: Word) {
        self.isCorrectAnswer = isCorrectAnswer
        self.word = word
    }

    func next() -> GuessTranslation.Word {
        word
    }
    
    func checkAnswer(word: GuessTranslation.Word, answer: Bool) -> Bool {
        isCorrectAnswer
    }
}
