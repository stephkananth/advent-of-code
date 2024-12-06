import Foundation

let example = Day6(.example)
let puzzle = Day6(.puzzle)

print("Day 6")
print("------")

// MARK: - Part 1

let partOneExampleSolution = 41

let partOneExampleResult = example.solvePartOne()

let partOneResult = puzzle.solvePartOne()

print("Part 1: \(partOneResult)")

// MARK: - Part 2

//let partTwoExampleSolution = 123

//let partTwoExampleResult = example.solvePartTwo()

//let partTwoResult = puzzle.solvePartTwo()

//print("Part 2: \(partTwoResult)\n")

class Day6: Puzzle<Map>, Solvable {
    override public var puzzleFile: String { #file }

    func solvePartOne() -> Int {
        var map = input.map
        return map.move()
    }

    func solvePartTwo() -> Int {
        return 0
    }
}

struct Map: Parsable {
    var map: [[Position]] = []

    init(from file: String) {
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
}

extension Character {
    var position: Position? {
        Position(self)
    }
}

enum Position: Equatable {
    case current(Direction)
    case notVisited
    case obstacle
    case visited

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
        case ".": self = .notVisited
        case "#": self = .obstacle
        case "X": self = .visited
        default: return nil
        }
    }
}

extension Position: CustomStringConvertible {
    var description: String {
        switch self {
        case .current(let direction): direction.rawValue
        case .notVisited: "."
        case .obstacle: "#"
        case .visited: "X"
        }
    }
}

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

    var nextPosition: Position? {
        guard !isOutOfBounds(index: nextIndex) else {
            return nil
        }

        let (row, column) = nextIndex
        return self[row][column]
    }

    var nextIndex: (row: Index, column: Index) {
        var (row, column) = currentIndex
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

    func isOutOfBounds(index: (row: Index, column: Index)) -> Bool {
        index.row < minRow ||
        index.row > maxRow ||
        index.column < minColumn ||
        index.column > maxColumn
    }

    var maxRow: Int {
        count - 1
    }

    var maxColumn: Int {
        (first?.count ?? 0) - 1
    }

    var minRow: Int {
        0
    }

    var minColumn: Int {
        0
    }

    var currentDirection: Direction {
        let (row, column) = currentIndex
        if case .current(let direction) = self[row][column] {
            return direction
        }
        fatalError("Could not find current direction")
    }

    var currentIndex: (row: Index, column: Index) {
        firstIndex(of: Direction.allCases.map(\.position))
    }

    func firstIndex(of positions: [Position]) -> (row: Index, column: Index) {
        for row in 0..<count {
            for column in 0..<self[row].count {
                if positions.contains(self[row][column]) {
                    return (row: row, column: column)
                }
            }
        }
        fatalError("Could not find first index of positions: \(positions)")
    }

    var visitedCount: Int {
        map(\.visitedCount).reduce(0, +)
    }

    var maxVisited: Int {
        map(\.count).reduce(0, +) - map(\.obstacleCount).reduce(0, +)
    }
}

extension [Position] {
    var visitedCount: Int {
        filter(\.isVisited).count
    }

    var obstacleCount: Int {
        filter(\.isObstacle).count
    }
}
