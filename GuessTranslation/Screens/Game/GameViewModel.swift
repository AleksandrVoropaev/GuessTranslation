//
//  GameViewModel.swift
//  GuessTranslation
//
//  Created by Oleksandr Voropayev on 08.11.2023.
//

import Foundation

extension GameView {
    final class ViewModel: ObservableObject {
        let words: [Word]

        init() {
            self.words = Word.mock
            print(words)
        }
    }
}
