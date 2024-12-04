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
        solve()
    }

    public func solvePartTwo() -> Int {
        Day3Part2(inputType).solve()
    }
}
