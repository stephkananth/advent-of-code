//
//  Day1.swift
//
//
//  Created by Stephanie Ananth on 12/1/24.
//

import Foundation

public struct Day1: Solvable {
    public let puzzleFile = #file
    public let inputType: InputType

    public private(set) var input: LocationIDs!

    public init(_ inputType: InputType) {
        self.inputType = inputType
        defer {
            self.input = LocationIDs(from: inputFile)
        }
    }

    public func solvePartOne() -> Int {
        (0..<input.count).reduce(into: 0) { partialSum, i in
            partialSum += abs(input.left[i] - input.right[i])
        }
    }

    public func solvePartTwo() -> Int {
        (0..<input.count).reduce(into: 0) { partialSum, i in
            let left = input.left[i]
            partialSum += (left * input.right.filter { $0 == left }.count)
        }
    }
}
