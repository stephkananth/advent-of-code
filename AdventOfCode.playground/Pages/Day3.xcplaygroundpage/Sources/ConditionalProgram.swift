//
//  ConditionalProgram.swift
//  
//
//  Created by Stephanie Ananth on 12/3/24.
//

import Foundation

public struct ConditionalProgram: Parsable, Programmable {
    public private(set) var program = [[Int]]()

    public init(from file: String) {
        program = getRawText(from: file)
            .components(separatedBy: "do()")
            .map { $0.components(separatedBy: "don't()") }
            .compactMap(\.first)
            .joined()
            .program
    }
}
