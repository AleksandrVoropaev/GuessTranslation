//
//  GameState.swift
//  GuessTranslation
//
//  Created by Oleksandr Voropayev on 08.11.2023.
//

import Foundation

struct GameState {
    var correct: Int
    var wrong: Int
}

extension GameState {
    var all: Int { correct + wrong }
}

extension GameState {
    static var initial: Self {
        GameState(correct: 0, wrong: 0)
    }
}
