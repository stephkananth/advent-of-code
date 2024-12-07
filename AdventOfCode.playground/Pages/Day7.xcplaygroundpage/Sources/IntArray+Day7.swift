//
//  IntArray+Day7.swift
//
//
//  Created by Stephanie Ananth on 12/7/24.
//

import Foundation

extension [Int] {
    func evaluates(to target: Int) -> Bool {
        if count == 1, let first {
            return first == target
        }

        return !Operation.allCases.filter {
            var copy = self
            let partialResult = copy.removeFirst()

            switch $0 {
            case .add:
                copy[0] += partialResult
            case .multiply:
                copy[0] *= partialResult
            }

            return copy.evaluates(to: target)
        }
        .isEmpty
    }
}
