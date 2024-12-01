//
//  Puzzle.swift
//
//
//  Created by Stephanie Ananth on 12/1/24.
//

import Foundation

public protocol Puzzle {
    associatedtype OutputType: Equatable

    var puzzleFile: String { get }

    var inputType: InputType { get }

    func solvePartOne() -> OutputType

    func solvePartTwo() -> OutputType
}

public extension Puzzle {
    var inputFile: String {
        puzzleFile.getInputFile(for: inputType)
    }
}
