//
//  Day4.swift
//
//
//  Created by Stephanie Ananth on 12/4/24.
//

import Foundation

public class Day4: Puzzle<WordSearch>, Solvable {
    override public var puzzleFile: String { #file }

    public func solvePartOne() -> Int {
        input.strings.map(\.xmasCount).reduce(0, +)
    }

    public func solvePartTwo() -> Int {
        input.wordSearch.xmasShapeCount
    }
}
