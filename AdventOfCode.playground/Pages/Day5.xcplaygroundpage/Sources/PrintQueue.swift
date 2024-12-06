//
//  PrintQueue.swift
//
//
//  Created by Stephanie Ananth on 12/5/24.
//

import Foundation

public struct PrintQueue: Parsable {
    private(set) var rules: [Int: (before: Set<Int>, after: Set<Int>)] = [:]
    private(set) var updates: [[Int]] = []

    public init(from file: String) {
        let components = getRawText(from: file).components(separatedBy: "\n\n")

        components[0]
            .components(separatedBy: "\n")
            .forEach { rawRule in
                let line = rawRule.components(separatedBy: "|")
                if let left = Int(line[0]), let right = Int(line[1]) {
                    if !rules.keys.contains(left) {
                        rules[left] = (before: [], after: [right])
                    } else {
                        rules[left]?.after.insert(right)
                    }

                    if !rules.keys.contains(right) {
                        rules[right] = (before: [left], after: [])
                    } else {
                        rules[right]?.before.insert(left)
                    }
                }
            }

        updates = components[1]
            .components(separatedBy: "\n")
            .map { $0.components(separatedBy: ",").compactMap { Int($0) } }
            .filter { !$0.isEmpty }
    }
}
