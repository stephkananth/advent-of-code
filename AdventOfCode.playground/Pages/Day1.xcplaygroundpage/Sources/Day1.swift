//
//  Day1.swift
//  
//
//  Created by Stephanie Ananth on 12/1/24.
//

public struct Day1: Puzzlable {
    public let puzzleFile = #file
    public private(set) var inputType: InputType

    public init(_ inputType: InputType) {
        self.inputType = inputType
    }

    public func solvePartOne() -> Int {
        let locationIds = LocationIDs(from: inputFile)
        return (0..<locationIds.count).reduce(into: 0) { partialSum, i in
            partialSum += abs(locationIds.left[i] - locationIds.right[i])
        }
    }

    public func solvePartTwo() -> Int {
        let locationIds = LocationIDs(from: inputFile)
        return (0..<locationIds.count).reduce(into: 0) { partialSum, i in
            let left = locationIds.left[i]
            partialSum += (left * locationIds.right.filter { $0 == left }.count)
        }
    }
}
