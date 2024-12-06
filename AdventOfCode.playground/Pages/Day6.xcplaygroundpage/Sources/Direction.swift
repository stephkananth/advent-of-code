//
//  Direction.swift
//
//
//  Created by Stephanie Ananth on 12/6/24.
//

import Foundation

enum Direction: String, CaseIterable {
    case up = "^"
    case right = ">"
    case down = "v"
    case left = "<"

    var position: Position {
        .current(self)
    }
    
    func turn() -> Direction {
        switch self {
        case .up: .right
        case .right: .down
        case .down: .left
        case .left: .up
        }
    }
}
