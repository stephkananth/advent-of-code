//
//  Day2.swift
//  
//
//  Created by Stephanie Ananth on 12/2/24.
//

import Foundation

public struct Day2: Puzzlable {
    public let puzzleFile = #file
    public let inputType: InputType

    public private(set) var input: Reports!

    private var reports: [[Int]] {
        input.reports
    }

    public init(_ inputType: InputType) {
        self.inputType = inputType
        defer {
            self.input = Reports(from: inputFile)
        }
    }

    public func solvePartOne() -> Int {
        reports.filter(\.isSafe).count
    }

    public func solvePartTwo() -> Int {
        reports.filter(\.couldBeSafe).count
    }
}

fileprivate extension [Int] {
    var isSafe: Bool {
        guard count > 1 else { return true }

        let firstDiff = self[1] - self[0]
        if abs(firstDiff) < 1 || abs(firstDiff) > 3 { return false }
        let isIncreasing = firstDiff > 0

        for i in (2..<count) {
            let diff = self[i] - self[i - 1]
            if abs(diff) < 1 || abs(diff) > 3 { return false }
            if (isIncreasing && diff < 0) || (!isIncreasing && diff > 0) {
                return false
            }
        }
        return true
    }

    var couldBeSafe: Bool {
        var copy = self
        for i in (0..<count) {
            copy.remove(at: i)
            if copy.isSafe { return true }
            copy = self
        }
        return false
    }
}
