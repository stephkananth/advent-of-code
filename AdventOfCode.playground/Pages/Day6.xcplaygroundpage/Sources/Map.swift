//
//  Map.swift
//
//
//  Created by Stephanie Ananth on 12/6/24.
//

import Foundation

public struct Map: Parsable {
    var map: [[Position]] = []

    public init(from file: String) {
        map = Array(
            getRawText(from: file)
                .components(separatedBy: "\n")
        )
        .map {
            Array($0)
                .compactMap(\.position)
        }
        .filter { !$0.isEmpty }
    }

    init(_ map: [[Position]]) {
        self.map = map
    }
}
