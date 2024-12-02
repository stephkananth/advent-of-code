//
//  Puzzlable.swift
//
//
//  Created by Stephanie Ananth on 12/1/24.
//

import Foundation

public protocol Puzzlable {
    associatedtype OutputType: Equatable
    associatedtype Input: Inputable

    var puzzleFile: String { get }

    var inputType: InputType { get }

    var input: Input! { get }

    init(_ inputType: InputType)

    mutating func solvePartOne() -> OutputType

    mutating func solvePartTwo() -> OutputType
}

public extension Puzzlable {
    var inputFile: String {
        puzzleFile.getInputFile(for: inputType)
    }
}
