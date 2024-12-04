//
//  WordSearch.swift
//
//
//  Created by Stephanie Ananth on 12/4/24.
//

import Foundation

public struct WordSearch: Parsable {
    private(set) var wordSearch = [[Character]]()

    var strings: [String] {
        var strings = [String]()
        strings.append(contentsOf: wordSearch.rows)
        strings.append(contentsOf: wordSearch.columns)
        strings.append(contentsOf: wordSearch.forwardDiagonals)
        strings.append(contentsOf: wordSearch.backwardDiagonals)
        return strings
    }

    public init(from file: String) {
        wordSearch = getRawText(from: file)
            .components(separatedBy: "\n")
            .map { Array($0) }
            .filter { !$0.isEmpty }
    }
}
