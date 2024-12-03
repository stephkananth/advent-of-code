//
//  Day3.swift
//  
//
//  Created by Stephanie Ananth on 12/3/24.
//

import Foundation

public class Day3: Puzzle<Program>, Solvable {
    override public var puzzleFile: String { #file }

    public func solvePartOne() -> Int {
        input.program.reduce(0) { $0 + $1[0] * $1[1] }
    }

    public func solvePartTwo() -> Int {
        Day3Part2(inputType).solvePartTwo()
    }
}
