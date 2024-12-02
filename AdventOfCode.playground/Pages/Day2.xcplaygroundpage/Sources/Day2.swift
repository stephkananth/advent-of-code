//
//  Day2.swift
//  
//
//  Created by Stephanie Ananth on 12/2/24.
//

import Foundation

public class Day2: Puzzle<Reports>, Solvable {
    override public var puzzleFile: String { #file }

    private var reports: [[Int]] {
        input.reports
    }

    public func solvePartOne() -> Int {
        reports.filter(\.isSafe).count
    }

    public func solvePartTwo() -> Int {
        reports.filter(\.couldBeSafe).count
    }
}
