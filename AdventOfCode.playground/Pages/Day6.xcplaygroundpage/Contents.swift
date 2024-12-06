import Foundation

let example = Day6(.example)
let puzzle = Day6(.puzzle)

print("Day 6")
print("------")

// MARK: - Part 1

let partOneExampleSolution = 143

let partOneExampleResult = example.solvePartOne()

//let partOneResult = puzzle.solvePartOne()

//print("Part 1: \(partOneResult)")

// MARK: - Part 2

//let partTwoExampleSolution = 123

//let partTwoExampleResult = example.solvePartTwo()

//let partTwoResult = puzzle.solvePartTwo()

//print("Part 2: \(partTwoResult)\n")

class Day6: Puzzle<Map>, Solvable {
    override public var puzzleFile: String { #file }

    func solvePartOne() -> Int {
        input.map.forEach { print($0) }
        return 0
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
    }
}

extension Character {
    var position: Position? {
        Position(self)
    }
}

enum Position {
    case current(Direction)
    case notVisited
    case obstacle
    case visited

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

    @discardableResult
    mutating func turn() -> Direction {
        switch self {
        case .up: self = .right
        case .right: self = .down
        case .down: self = .left
        case .left: self = .up
        }
        return self
    }
}
