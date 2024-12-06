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
            self[currRow][currColumn] = .visited
        }

        return move()
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

    private var currentDirection: Direction {
        let (row, column) = currentIndex
        if case .current(let direction) = self[row][column] {
            return direction
        }
        fatalError("Could not find current direction")
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
                if positions.contains(self[row][column]) {
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
