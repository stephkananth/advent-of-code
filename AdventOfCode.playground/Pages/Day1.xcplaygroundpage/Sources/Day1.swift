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
        (0..<input.left.count).reduce(into: 0) { partialSum, i in
            partialSum += abs(input.left[i] - input.right[i])
        }
    }

    public func solvePartTwo() -> Int {
        (0..<input.left.count).reduce(into: 0) { partialSum, i in
            let left = input.left[i]
            partialSum += (left * input.right.filter { $0 == left }.count)
        }
    }
}
