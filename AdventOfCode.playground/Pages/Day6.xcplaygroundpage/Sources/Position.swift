//
//  Position.swift
//
//
//  Created by Stephanie Ananth on 12/6/24.
//

import Foundation

enum Position: Equatable {
    case current(Direction)
    case obstacle
    case unvisited
    case visited(seen: Set<Direction> = [], direction: Direction? = nil)

    var isVisited: Bool {
        switch self {
        case .current, .visited: true
        default: false
        }
    }

    var isObstacle: Bool {
        self == .obstacle
    }

    init?(_ c: Character) {
        switch c {
        case "^": self = .current(.up)
        case ">": self = .current(.right)
        case "v": self = .current(.down)
        case "<": self = .current(.left)
        case "#": self = .obstacle
        case ".": self = .unvisited
        case "X": self = .visited()
        default: return nil
        }
    }
}

extension Position: CustomStringConvertible {
    var description: String {
        switch self {
        case .current(let direction): direction.rawValue
        case .obstacle: "#"
        case .unvisited: "."
        case .visited: "X"
        }
    }
}
