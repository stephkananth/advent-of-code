//
//  Map.swift
//
//
//  Created by Stephanie Ananth on 12/6/24.
//

import Foundation

public struct Map: Parsable {

    // MARK: Variables

    var map: [[Position]] = []

    private lazy var currentIndex: (row: Int, column: Int) = {
        firstIndex(of: Direction.allCases.map(\.position))
    }()

    private var currentPosition: Position {
        mutating get {
            let (row, column) = currentIndex
            return map[row][column]
        }
    }

    private var currentDirection: Direction {
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

    private var nextIndex: (row: Int, column: Int) {
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

    private var nextPosition: Position? {
        mutating get {
            guard !isOutOfBounds(index: nextIndex) else {
                return nil
            }
            return map[nextIndex.row][nextIndex.column]
        }
    }


    private var maxRow: Int {
        map.count - 1
    }

    private var maxColumn: Int {
        (map.first?.count ?? 0) - 1
    }

    private var visitedCount: Int {
        map.map(\.visitedCount).reduce(0, +)
    }

    // MARK: Inits

    public init(from file: String) {
        map = Array(
            getRawText(from: file)
                .components(separatedBy: "\n")
        )
        .map {
            Array($0)
                .compactMap(\.position)
        }
        .filter { !$0.isEmpty }
    }

    init(_ map: [[Position]]) {
        self.map = map
    }

    // MARK: Methods

    mutating func move() -> Int {
        guard let nextPosition else { return visitedCount }

        let (currRow, currColumn) = currentIndex
        let direction = currentDirection

        if nextPosition.isObstacle {
            map[currRow][currColumn] = .current(direction.turn())
        } else {
            let (nextRow, nextColumn) = nextIndex
            map[currRow][currColumn] = .visited()
            map[nextRow][nextColumn] = .current(direction)
            currentIndex = (nextRow, nextColumn)
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
            map[currRow][currColumn] = .visited(seen: [currDirection])
            map[nextRow][nextColumn] = .visited(direction: currDirection)
            currentIndex = (nextRow, nextColumn)

        case let (.current(currDirection), .visited(seen: nextSeen, _)):
            if nextSeen.contains(currDirection) { return true }
            map[currRow][currColumn] = .visited(seen: [currDirection])
            map[nextRow][nextColumn] = .visited(seen: nextSeen, direction: currDirection)
            currentIndex = (nextRow, nextColumn)

        case (.visited(seen: var currSeen, direction: let currDirection), _):
            guard let currDirection else { fatalError("Current direction should not be nil") }
            if currSeen.contains(currDirection) { return true }
            currSeen.insert(currDirection)

            switch nextPosition {
            case .obstacle:
                map[currRow][currColumn] = .visited(seen: currSeen, direction: currDirection.turn())

            case .unvisited:
                map[currRow][currColumn] = .visited(seen: currSeen)
                map[nextRow][nextColumn] = .visited(direction: currDirection)
                currentIndex = (nextRow, nextColumn)

            case .visited(seen: let nextSeen, _):
                map[currRow][currColumn] = .visited(seen: currSeen)
                map[nextRow][nextColumn] = .visited(seen: nextSeen, direction: currDirection)
                currentIndex = (nextRow, nextColumn)

            default:
                fatalError("Unknown value for next position: \(String(describing: nextPosition))")
            }
        }

        return nil
    }

    private func firstIndex(of positions: [Position]) -> (row: Int, column: Int) {
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

    private func isOutOfBounds(index: (row: Int, column: Int)) -> Bool {
        index.row < 0 || index.row > maxRow || index.column < 0 || index.column > maxColumn
    }
}
