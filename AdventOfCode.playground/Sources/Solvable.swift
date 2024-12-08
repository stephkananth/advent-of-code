//
//  Solvable.swift
//
//
//  Created by Stephanie Ananth on 12/1/24.
//

import Foundation

public protocol Solvable {
    func solvePartOne() -> Int
    func solvePartTwo() -> Int
}

public extension Solvable {
    func partOne() {
        printResult(of: solvePartOne, part: .one)
    }

    func partTwo() {
        printResult(of: solvePartTwo, part: .two)
    }
}

fileprivate extension Solvable {
    func printResult(of solve: () -> Int, part: Part) {
        let start = Date()
        let result = solve()
        print("Part \(part.rawValue): \(result), time: \(start.elapsed)s")
        if case .two = part {
            print()
        }
    }
}
