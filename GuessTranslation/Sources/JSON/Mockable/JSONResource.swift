//
//  JSONResource.swift
//  GuessTranslation
//
//  Created by Oleksandr Voropayev on 08.11.2023.
//

import Foundation

protocol Resource {
    var name: String { get }
    var fileType: String { get }
}

struct JSONResource: Resource {
    var name: String
    var fileType: String = "json"
}
