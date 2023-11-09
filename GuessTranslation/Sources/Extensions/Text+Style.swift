//
//  Text+Style.swift
//  GuessTranslation
//
//  Created by Oleksandr Voropayev on 08.11.2023.
//

import SwiftUI

extension Text {
    func main() -> some View {
        modifier(MainTextModifier())
    }

    func secondary() -> some View {
        modifier(SecondaryTextModifier())
    }
}

struct MainTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 32, weight: .bold, design: .rounded))
    }
}

struct SecondaryTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 24, weight: .semibold, design: .rounded))
    }
}
