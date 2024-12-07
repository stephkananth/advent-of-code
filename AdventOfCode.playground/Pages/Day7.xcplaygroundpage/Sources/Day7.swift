//
//  Day7.swift
//
//
//  Created by Stephanie Ananth on 12/7/24.
//

import Foundation

public class Day7: Puzzle<Calibrations>, Solvable {
    override public var puzzleFile: String { #file }

    public func solvePartOne() -> Int {
        input.calibrations
            .filter { $1.evaluates(to: $0) }
            .keys
            .reduce(0, +)
    }

    public func solvePartTwo() -> Int {
        0
    }
}
