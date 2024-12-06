//
//  Day2.swift
//
//
//  Created by Stephanie Ananth on 12/2/24.
//

import Foundation

public class Day2: Puzzle<Reports>, Solvable {
    override public var puzzleFile: String { #file }

    public func solvePartOne() -> Int {
        input.reports.filter(\.isSafe).count
    }

    public func solvePartTwo() -> Int {
        input.reports.filter(\.couldBeSafe).count
    }
}
