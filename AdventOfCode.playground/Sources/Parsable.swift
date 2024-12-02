//
//  Inputable.swift
//
//
//  Created by Stephanie Ananth on 12/2/24.
//

import Foundation

public protocol Parsable {
    init(from file: String)
}

public extension Parsable {
    func getRawText(from file: String) -> String {
        file.url.rawText
    }
}

fileprivate extension URL {
    var rawText: String {
        do {
            return try String(contentsOf: self, encoding: .utf8)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

fileprivate extension String {
    var url: URL {
        if let url = Bundle.main.url(forResource: self, withExtension: ".txt") {
            return url
        }
        fatalError("Unable to get url for file: \(self)")
    }
}
