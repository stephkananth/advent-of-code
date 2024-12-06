//
//  Day6.swift
//
//
//  Created by Stephanie Ananth on 12/6/24.
//

import Foundation

public class Day6: Puzzle<Map>, Solvable {
    override public var puzzleFile: String { #file }

    public func solvePartOne() -> Int {
        var map = input.map
        return map.move()
    }

    public func solvePartTwo() -> Int {
        return 0
    }
}
