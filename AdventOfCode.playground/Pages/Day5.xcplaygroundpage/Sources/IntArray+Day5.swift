//
//  IntArray+Day5.swift
//
//
//  Created by Stephanie Ananth on 12/5/24.
//

import Foundation

extension [Int] {
    var middleNumber: Int {
        self[count / 2]
    }

    func isInOrder(rules: [Int: (before: Set<Int>, after: Set<Int>)]) -> Bool {
        for (index, value) in enumerated() {
            if let rule = rules[value] {
                let afterValues = rule.after
                for beforeIndex in 0..<index {
                    if afterValues.contains(self[beforeIndex]) {
                        return false
                    }
                }

                let beforeValues = rule.before
                for afterIndex in (index + 1)..<count {
                    if beforeValues.contains(self[afterIndex]) {
                        return false
                    }
                }
            }
        }
        return true
    }

    func ordered(by rules: [Int: (before: Set<Int>, after: Set<Int>)]) -> [Int] {
        compactMap {
            if let before = rules[$0]?.before, let after = rules[$0]?.after {
                return Rule(id: $0, before: before, after: after)
            }
            return nil
        }
        .sorted()
        .map(\.id)
    }
}
