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
        guard var input else { fatalError("Input should not be nil") }
        return input.move()
    }

    public func solvePartTwo() -> Int {
        var result = 0
        (0..<input.map.count).forEach { row in
            (0..<input.map[row].count).forEach { column in
                if case .unvisited = input.map[row][column] {
                    var copy = Map(input.map)
                    copy.map[row][column] = .obstacle
                    var isLoop: Bool? = nil
                    while isLoop == nil {
                        isLoop = copy.isLoop()
                    }
                    if isLoop == true {
                        result += 1
                    }
                }
            }
        }
        return result
    }
}
