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
        var result = 0
        var map = input.map
        for row in 0..<map.count {
            for column in 0..<map[row].count {
                if case .unvisited = map[row][column] {
                    map[row][column] = .obstacle
                    if map.isLoop() {
                        print()
                        map.forEach { print($0) }
                        result += 1
                    }
                    map = input.map
                }
            }
        }
        return result
    }
}
