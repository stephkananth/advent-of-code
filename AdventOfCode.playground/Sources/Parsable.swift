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
        do {
            return try String(contentsOf: getURL(from: file), encoding: .utf8)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

fileprivate extension Parsable {
    func getURL(from file: String) -> URL {
        if let url = Bundle.main.url(forResource: file, withExtension: ".txt") {
            return url
        }
        fatalError("Unable to get url for file: \(file)")
    }
}
