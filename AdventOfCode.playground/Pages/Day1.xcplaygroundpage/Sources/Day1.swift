//
//  Day1.swift
//
//
//  Created by Stephanie Ananth on 12/1/24.
//

import Foundation

public class Day1: Puzzle<LocationIDs>, Solvable {
    override public var puzzleFile: String { #file }

    public func solvePartOne() -> Int {
        (0..<input.left.count)
            .reduce(0) { $0 + abs(input.left[$1] - input.right[$1]) }
    }

    public func solvePartTwo() -> Int {
        (0..<input.left.count)
            .reduce(0) {
                let left = input.left[$1]
                return $0 + (left * input.right.filter { $0 == left }.count)
            }
    }
}
