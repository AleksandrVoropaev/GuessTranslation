//
//  Mockable.swift
//  GuessTranslation
//
//  Created by Oleksandr Voropayev on 08.11.2023.
//

import Foundation

protocol Mockable {
    static var stub: JSONFileStub { get }
    static var mock: Self? { get }
}

extension Mockable where Self: Decodable {
    static var mock: Self? {
        stub.mock()
    }
}

protocol ArrayMockable: Mockable {}

extension ArrayMockable where Self: Decodable {
    static var mock: [Self] {
        stub.mock() ?? []
    }
}
