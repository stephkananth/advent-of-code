//
//  2DPositionArray+Day6.swift
//
//
//  Created by Stephanie Ananth on 12/6/24.
//

import Foundation

extension [[Position]] {
    mutating func move() -> Int {
        guard let nextPosition else { return visitedCount }

        let (currRow, currColumn) = currentIndex
        let direction = currentDirection

        if nextPosition.isObstacle {
            self[currRow][currColumn] = .current(direction.turn())
        } else {
            let (nextRow, nextColumn) = nextIndex
            self[nextRow][nextColumn] = .current(direction)
            self[currRow][currColumn] = .visited(seen: [], direction: nil)
        }

        return move()
    }

    mutating func isLoop() -> Bool {
        let (currRow, currColumn) = currentIndex
        let (nextRow, nextColumn) = nextIndex

        switch (currentPosition, nextPosition) {

            // MARK: Errors

        case (.obstacle, _):
            fatalError("Current position cannot be obstacle")

        case (.unvisited, _):
            fatalError("Current position cannot be unvisited")

        case (_, .current):
            fatalError("Next position cannot be current")

            // MARK: Successes

        case (_, nil):
            return false

        case let (.current(currDirection), .obstacle):
            self[currRow][currColumn] = .visited(seen: [currDirection], direction: currDirection.turn())

        case let (.current(currDirection), .unvisited):
            self[currRow][currColumn] = .visited(seen: [currDirection], direction: nil)
            self[nextRow][nextColumn] = .visited(seen: [], direction: currDirection)

        case let (.current(currDirection), .visited(seen: nextSeen, _)):
            if nextSeen.contains(currDirection) { return true }
            self[currRow][currColumn] = .visited(seen: [currDirection], direction: nil)
            self[nextRow][nextColumn] = .visited(seen: nextSeen, direction: currDirection)

        case (.visited(seen: var currSeen, direction: let currDirection), .obstacle):
            guard let currDirection else { fatalError("Current direction should not be nil") }
            if currSeen.contains(currDirection) { return true }
            currSeen.insert(currDirection)
            self[currRow][currColumn] = .visited(seen: currSeen, direction: currDirection.turn())

        case (.visited(seen: var currSeen, direction: let currDirection), .unvisited):
            guard let currDirection else { fatalError("Current direction should not be nil") }
            if currSeen.contains(currDirection) { return true }
            currSeen.insert(currDirection)
            self[currRow][currColumn] = .visited(seen: currSeen, direction: nil)
            self[nextRow][nextColumn] = .visited(seen: [], direction: currDirection)

        case (.visited(seen: var currSeen, direction: let currDirection), .visited(seen: let nextSeen, _)):
            guard let currDirection else { fatalError("Current direction should not be nil") }
            if currSeen.contains(currDirection) || nextSeen.contains(currDirection) { return true }
            currSeen.insert(currDirection)
            self[currRow][currColumn] = .visited(seen: currSeen, direction: nil)
            self[nextRow][nextColumn] = .visited(seen: nextSeen, direction: currDirection)
        }

        return isLoop()
    }
}

fileprivate extension [[Position]] {

    // MARK: Variables

    private var maxRow: Int {
        count - 1
    }

    private var maxColumn: Int {
        (first?.count ?? 0) - 1
    }

    private var visitedCount: Int {
        map(\.visitedCount).reduce(0, +)
    }

    private var currentIndex: (row: Index, column: Index) {
        firstIndex(of: Direction.allCases.map(\.position))
    }

    private var currentPosition: Position {
        let (row, column) = currentIndex
        return self[row][column]
    }

    private var currentDirection: Direction {
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

    private var nextIndex: (row: Index, column: Index) {
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

    private var nextPosition: Position? {
        let nextIndex = nextIndex
        guard !isOutOfBounds(index: nextIndex) else {
            return nil
        }
        return self[nextIndex.row][nextIndex.column]
    }

    // MARK: Functions

    private func firstIndex(of positions: [Position]) -> (row: Index, column: Index) {
        for row in 0..<count {
            for column in 0..<self[row].count {
                let position = self[row][column]
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

    private func isOutOfBounds(index: (row: Index, column: Index)) -> Bool {
        index.row < 0 ||
        index.row > maxRow ||
        index.column < 0 ||
        index.column > maxColumn
    }
}
