//
//  GameView.swift
//  GuessTranslation
//
//  Created by Oleksandr Voropayev on 08.11.2023.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    GameView()
}
