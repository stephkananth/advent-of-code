//
//  Inputable.swift
//  
//
//  Created by Stephanie Ananth on 12/2/24.
//

import Foundation

public protocol Inputable {
    init(from file: String)
}

public extension Inputable {
    func getRawText(from file: String) -> String {
        do {
            return try String(contentsOf: getURL(from: file), encoding: .utf8)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func getURL(from file: String) -> URL {
        guard let url = Bundle.main.url(forResource: file, withExtension: ".txt") else {
            fatalError("Unable to get url for file: \(file)")
        }
        return url
    }
}
