//
//  Puzzlable.swift
//
//
//  Created by Stephanie Ananth on 12/1/24.
//

import Foundation

public protocol Puzzlable {
    associatedtype OutputType: Equatable

    var puzzleFile: String { get }

    var inputType: InputType { get }

    init(_ inputType: InputType)

    func solvePartOne() -> OutputType

    func solvePartTwo() -> OutputType
}

public extension Puzzlable {
    var inputFile: String {
        puzzleFile.getInputFile(for: inputType)
    }
}
