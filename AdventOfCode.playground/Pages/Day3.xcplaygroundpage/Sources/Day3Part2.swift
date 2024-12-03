//
//  Day3Part2.swift
//  
//
//  Created by Stephanie Ananth on 12/3/24.
//

import Foundation

public class Day3Part2: Puzzle<ConditionalProgram>, Solvable {
    override public var puzzleFile: String { #file }

    public func solvePartOne() -> Int {
        fatalError("Day3Part2.solvePartOne() is unimplemented, use Day3.solvePartOne()")
    }

    public func solvePartTwo() -> Int {
        input.program.reduce(0) { $0 + $1[0] * $1[1] }
    }
}
