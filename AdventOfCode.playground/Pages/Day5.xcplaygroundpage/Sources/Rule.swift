//
//  Rule.swift
//
//
//  Created by Stephanie Ananth on 12/5/24.
//

import Foundation

struct Rule: Comparable, Identifiable {
    let id: Int
    let before: Set<Int>
    let after: Set<Int>

    static func < (lhs: Rule, rhs: Rule) -> Bool {
        lhs.after.contains(rhs.id)
    }
}
