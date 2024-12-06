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
            for beforeIndex in 0..<index {
                if rules[value]?.after.contains(self[beforeIndex]) == true {
                    return false
                }
            }

            for afterIndex in (index + 1)..<count {
                if rules[value]?.before.contains(self[afterIndex]) == true {
                    return false
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
