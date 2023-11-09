//
//  GameState.swift
//  GuessTranslation
//
//  Created by Oleksandr Voropayev on 08.11.2023.
//

import Foundation

struct GameState: Equatable {
    var correct: Int
    var wrong: Int
}

extension GameState {
    var all: Int { correct + wrong }
    var scoreString: String { "Correct - \(correct) / Wrong - \(wrong)"}
}

extension GameState {
    static var initial: Self {
        GameState(correct: 0, wrong: 0)
    }
}
