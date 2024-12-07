//
//  IntArray+Day7.swift
//
//
//  Created by Stephanie Ananth on 12/7/24.
//

import Foundation

extension [Int] {
    func evaluates(to target: Int, operations: [Operation] = Operation.allCases) -> Bool {
        if count == 1, let first {
            return first == target
        }

        return !operations.filter {
            var copy = self
            let partialResult = copy.removeFirst()

            switch $0 {
            case .add:
                copy[0] += partialResult
            case .concatenate:
                copy[0] = Int("\(partialResult)\(copy[0])")!
            case .multiply:
                copy[0] *= partialResult
            }

            return copy.evaluates(to: target, operations: operations)
        }
        .isEmpty
    }
}
