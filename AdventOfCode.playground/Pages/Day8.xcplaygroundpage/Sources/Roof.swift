//
//  Roof.swift
//
//
//  Created by Stephanie Ananth on 12/9/24.
//

import Foundation

public struct Roof: Parsable {
    var roof: [[Antenna?]] = []

    public init(from file: String) {
        roof = getRawText(from: file)
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }
            .map { Array($0).map(\.antenna) }
    }
}
