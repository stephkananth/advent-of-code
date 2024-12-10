import Foundation

let example = Day8(.example)
let puzzle = Day8(.puzzle)

print("Day 8")
print("------")

// MARK: - Part 1

let partOneExampleSolution = 14

let partOneExampleResult = example.solvePartOne()

if partOneExampleResult == partOneExampleSolution {
    puzzle.partOne()
}

// MARK: - Part 2

let partTwoExampleSolution = 34

let partTwoExampleResult = example.solvePartTwo()

if partTwoExampleResult == partTwoExampleSolution {
    puzzle.partTwo()
}

class Day8: Puzzle<Roof>, Solvable {
    override public var puzzleFile: String { #file }

    func solvePartOne() -> Int {
        Set(
            input.roof.antennas.flatMap { (_, indexes) in
                indexes.flatMap { i in
                    indexes
                        .filter { i != $0 }
                        .flatMap { j in
                            [2 * i - j, 2 * j - i].filter { index in
                                input.roof.isValid(index: index)
                            }
                        }
                }
            }
        )
        .count
    }

    func solvePartTwo() -> Int {
        Set(
            input.roof.antennas.flatMap { (_, indexes) in
                indexes.flatMap { i in
                    indexes
                        .filter { i != $0 }
                        .flatMap { j in
                            input.roof.inLine(index1: i, index2: j).filter { index in
                                input.roof.isValid(index: index)
                            }
                        }
                }
            }
        )
        .count
    }
}

struct Roof: Parsable {
    var roof: [[Antenna?]] = []

    init(from file: String) {
        roof = getRawText(from: file)
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }
            .map { Array($0).map(\.antenna) }
    }
}

struct RoofIndex: Equatable, Hashable, Comparable {
    var row: Int
    var column: Int

    static func +(lhs: RoofIndex, rhs: RoofIndex) -> RoofIndex {
        RoofIndex(row: lhs.row + rhs.row, column: lhs.column + rhs.column)
    }

    static func -(lhs: RoofIndex, rhs: RoofIndex) -> RoofIndex {
        RoofIndex(row: lhs.row - rhs.row, column: lhs.column - rhs.column)
    }

    static func *(lhs: Int, rhs: RoofIndex) -> RoofIndex {
        RoofIndex(row: lhs * rhs.row, column: lhs * rhs.column)
    }

    static func +=(lhs: inout RoofIndex, rhs: RoofIndex) {
        lhs.row += rhs.row
        lhs.column += rhs.column
    }

    static func -=(lhs: inout RoofIndex, rhs: RoofIndex) {
        lhs.row -= rhs.row
        lhs.column -= rhs.column
    }

    static func < (lhs: RoofIndex, rhs: RoofIndex) -> Bool {
        if lhs.row == rhs.row {
            return lhs.column < rhs.column
        }
        return lhs.row < rhs.row
    }
}

enum Antenna: Hashable {
    case node(Character)
    case antinode(Character)

    var rawValue: Character {
        switch self {
        case .node(let character), .antinode(let character):
            character
        }
    }

    func prettyPrint() -> String {
        switch self {
        case .node(let character):
            "\(character)"
        case .antinode:
            "#"
        }
    }
}

extension Character {
    var antenna: Antenna? {
        switch self {
        case ".": return nil
        case "#": return .antinode(self)
        default: return .node(self)
        }
    }
}

extension [[Antenna?]] {
    var maxRow: Int {
        count - 1
    }

    var maxColumn: Int {
        (first?.count ?? 0) - 1
    }

    func isValid(index: RoofIndex) -> Bool {
        let (row, column) = (index.row, index.column)
        guard row >= 0, column >= 0, row <= maxRow, column <= maxColumn else {
            return false
        }
        return true
    }

    mutating func insertAntinode(for antenna: Antenna, at index: RoofIndex) -> Bool {
        guard isValid(index: index) else { return false }
        let (row, column) = (index.row, index.column)
        if let existing = self[row][column], existing == .antinode(antenna.rawValue) { return false }
        self[row][column] = .antinode(antenna.rawValue)
        return true
    }

    var antennas: [Antenna: [RoofIndex]] {
        var antennas: [Antenna: [RoofIndex]] = [:]
        for row in 0..<count {
            for column in 0..<self[row].count {
                if let antenna = self[row][column] {
                    let index = RoofIndex(row: row, column: column)
                    if antennas.keys.contains(antenna) {
                        antennas[antenna]?.append(index)
                    } else {
                        antennas[antenna] = [index]
                    }
                }
            }
        }
        return antennas
    }

    func inLine(index1: RoofIndex, index2: RoofIndex) -> [RoofIndex] {
        let difference = index2 - index1
        var indexes: [RoofIndex] = []

        var additiveIndex = index1
        while isValid(index: additiveIndex) {
            indexes.append(additiveIndex)
            additiveIndex += difference
        }

        var subtractiveIndex = index1
        while isValid(index: subtractiveIndex) {
            indexes.append(subtractiveIndex)
            subtractiveIndex -= difference
        }

        return indexes
    }
}

extension [[Antenna?]] {
    func prettyPrint() {
        forEach { $0.prettyPrint() }
    }
}

extension [Antenna?] {
    func prettyPrint() {
        print(reduce("") { "\($0)\($1 == nil ? "." : $1!.prettyPrint())" })
    }
}
