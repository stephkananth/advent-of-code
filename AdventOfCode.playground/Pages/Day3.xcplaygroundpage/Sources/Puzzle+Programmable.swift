//
//  Puzzle+Programmable.swift
//  
//
//  Created by Stephanie Ananth on 12/4/24.
//

import Foundation

extension Puzzle where Input: Programmable {
    func solve() -> Int {
        input.program.reduce(0) { $0 + $1[0] * $1[1] }
    }
}
