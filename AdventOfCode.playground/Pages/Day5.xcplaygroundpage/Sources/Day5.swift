//
//  Day5.swift
//
//
//  Created by Stephanie Ananth on 12/5/24.
//

import Foundation

public class Day5: Puzzle<PrintQueue>, Solvable {
    override public var puzzleFile: String { #file }

    public func solvePartOne() -> Int {
        input.updates.reduce(0) {
            $0 + ($1.isInOrder(rules: input.rules) ? $1.middleNumber : 0)
        }
    }

    public func solvePartTwo() -> Int {
        input.updates
            .filter { !$0.isInOrder(rules: input.rules) }
            .map { $0.ordered(by: input.rules).middleNumber }
            .reduce(0, +)
    }
}
