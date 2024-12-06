//
//  2DPositionArray+Day6.swift
//
//
//  Created by Stephanie Ananth on 12/6/24.
//

import Foundation

extension Map {
    mutating func move() -> Int {
        guard let nextPosition else { return visitedCount }

        let (currRow, currColumn) = currentIndex
        let direction = currentDirection

        if nextPosition.isObstacle {
            map[currRow][currColumn] = .current(direction.turn())
        } else {
            let (nextRow, nextColumn) = nextIndex
            map[nextRow][nextColumn] = .current(direction)
            currentIndex = (nextRow, nextColumn)
            map[currRow][currColumn] = .visited(seen: [], direction: nil)
        }

        return move()
    }

    mutating func isLoop() -> Bool? {
        let (currRow, currColumn) = currentIndex
        let (nextRow, nextColumn) = nextIndex

        switch (currentPosition, nextPosition) {
        case (_, nil):
            return false

        case (.obstacle, _):
            fatalError("Current position cannot be obstacle")

        case (.unvisited, _):
            fatalError("Current position cannot be unvisited")

        case (_, .current):
            fatalError("Next position cannot be current")

        case let (.current(currDirection), .obstacle):
            map[currRow][currColumn] = .visited(seen: [currDirection], direction: currDirection.turn())

        case let (.current(currDirection), .unvisited):
            map[currRow][currColumn] = .visited(seen: [currDirection], direction: nil)
            map[nextRow][nextColumn] = .visited(seen: [], direction: currDirection)
            currentIndex = (nextRow, nextColumn)

        case let (.current(currDirection), .visited(seen: nextSeen, _)):
            if nextSeen.contains(currDirection) { return true }
            map[currRow][currColumn] = .visited(seen: [currDirection], direction: nil)
            map[nextRow][nextColumn] = .visited(seen: nextSeen, direction: currDirection)
            currentIndex = (nextRow, nextColumn)

        case (.visited(seen: var currSeen, direction: let currDirection), .obstacle):
            guard let currDirection else { fatalError("Current direction should not be nil") }
            if currSeen.contains(currDirection) { return true }
            currSeen.insert(currDirection)
            map[currRow][currColumn] = .visited(seen: currSeen, direction: currDirection.turn())

        case (.visited(seen: var currSeen, direction: let currDirection), .unvisited):
            guard let currDirection else { fatalError("Current direction should not be nil") }
            if currSeen.contains(currDirection) { return true }
            currSeen.insert(currDirection)
            map[currRow][currColumn] = .visited(seen: currSeen, direction: nil)
            map[nextRow][nextColumn] = .visited(seen: [], direction: currDirection)
            currentIndex = (nextRow, nextColumn)

        case (.visited(seen: var currSeen, direction: let currDirection), .visited(seen: let nextSeen, _)):
            guard let currDirection else { fatalError("Current direction should not be nil") }
            if currSeen.contains(currDirection) || nextSeen.contains(currDirection) { return true }
            currSeen.insert(currDirection)
            map[currRow][currColumn] = .visited(seen: currSeen, direction: nil)
            map[nextRow][nextColumn] = .visited(seen: nextSeen, direction: currDirection)
            currentIndex = (nextRow, nextColumn)
        }

        return nil
    }
}

extension Map {

    // MARK: Variables

    var maxRow: Int {
        map.count - 1
    }

    var maxColumn: Int {
        (map.first?.count ?? 0) - 1
    }

    var visitedCount: Int {
        map.map(\.visitedCount).reduce(0, +)
    }

    var currentPosition: Position {
        mutating get {
            let (row, column) = currentIndex
            return map[row][column]
        }
    }

    var currentDirection: Direction {
        mutating get {
            switch currentPosition {
            case .current(let direction):
                return direction
            case .visited(_, let direction):
                guard let direction else {
                    fatalError("Could not find current direction")
                }
                return direction
            default:
                fatalError("Could not find current direction")
            }
        }
    }

    var nextIndex: (row: Int, column: Int) {
        mutating get {
            let (row, column) = currentIndex
            switch currentDirection {
            case .up:
                return (row - 1, column)
            case .right:
                return (row, column + 1)
            case .down:
                return (row + 1, column)
            case .left:
                return (row, column - 1)
            }
        }
    }

    var nextPosition: Position? {
        mutating get {
            let nextIndex = nextIndex
            guard !isOutOfBounds(index: nextIndex) else {
                return nil
            }
            return map[nextIndex.row][nextIndex.column]
        }
    }

    // MARK: Functions

    func firstIndex(of positions: [Position]) -> (row: Int, column: Int) {
        for row in 0..<map.count {
            for column in 0..<map[row].count {
                let position = map[row][column]
                if case .visited(_, let currDirection) = position, currDirection != nil {
                    return (row: row, column: column)
                }
                if positions.contains(position) {
                    return (row: row, column: column)
                }
            }
        }
        fatalError("Could not find first index of positions: \(positions)")
    }

    func isOutOfBounds(index: (row: Int, column: Int)) -> Bool {
        index.row < 0 ||
        index.row > maxRow ||
        index.column < 0 ||
        index.column > maxColumn
    }
}
