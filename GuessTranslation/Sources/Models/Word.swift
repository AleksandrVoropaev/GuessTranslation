//
//  Word.swift
//  GuessTranslation
//
//  Created by Oleksandr Voropayev on 08.11.2023.
//

import Foundation

struct Word: Decodable {
    let english: String
    let spanish: String

    enum CodingKeys: String, CodingKey {
        case english = "text_eng"
        case spanish = "text_spa"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.english = try container.decode(String.self, forKey: .english)
        self.spanish = try container.decode(String.self, forKey: .spanish)
    }
}

extension Word: ArrayMockable {
    static var stub: JSONFileStub {
        .makeResourceWords200()
    }
}
