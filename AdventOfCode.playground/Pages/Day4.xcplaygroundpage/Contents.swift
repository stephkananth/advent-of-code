import Foundation

let example = Day4(.example)
let puzzle = Day4(.puzzle)

print("Day 4")
print("------")

// MARK: - Part 1

let partOneExampleSolution = 18

let partOneExampleResult = example.solvePartOne()

let partOneResult = puzzle.solvePartOne()

print("Part 1: \(partOneResult)")

// MARK: - Part 2

//let partTwoExampleSolution = 48

//let partTwoExampleResult = example.solvePartTwo()

//let partTwoResult = puzzle.solvePartTwo()

//print("Part 2: \(partTwoResult)\n")

class Day4: Puzzle<WordSearch>, Solvable {
    override public var puzzleFile: String { #file }

    func solvePartOne() -> Int {
        input.strings.reduce(0) { $0 + $1.xmasCount }
    }

    func solvePartTwo() -> Int {
        return 0
    }
}

struct WordSearch: Parsable {
    var wordSearch = [[Character]]()

    var strings: [String] {
        var strings = [String]()
        strings.append(contentsOf: wordSearch.rows)
        strings.append(contentsOf: wordSearch.columns)
        strings.append(contentsOf: wordSearch.forwardDiagonals)
        strings.append(contentsOf: wordSearch.backwardDiagonals)
        return strings
    }

    init(from file: String) {
        wordSearch = getRawText(from: file)
            .components(separatedBy: "\n")
            .map { Array($0) }
    }
}

extension String {
    var xmasCount: Int {
        matches(of: /XMAS/).count + matches(of: /SAMX/).count
    }
}

extension [[Character]] {
    var rows: [String] {
        map { String($0) }
    }

    var columns: [String] {
        guard let first else { return [] }
        var columns = [String](repeating: "", count: first.count)
        for rowIndex in 0..<count {
            for columnIndex in 0..<self[rowIndex].count {
                columns[columnIndex] += String(self[rowIndex][columnIndex])
            }
        }
        return columns
    }

    var forwardDiagonals: [String] {
        guard let first else { return [] }
        var forwardDiagonals = [String](repeating: "", count: count + first.count - 1)
        for rowIndex in 0..<count {
            for columnIndex in 0..<self[rowIndex].count {
                forwardDiagonals[rowIndex + columnIndex] += String(self[rowIndex][columnIndex])
            }
        }
        return forwardDiagonals
    }

    var backwardDiagonals: [String] {
        guard let first else { return [] }
        var backwardDiagonals = [String](repeating: "", count: count + first.count - 1)
        for rowIndex in 0..<count {
            for columnIndex in 0..<self[rowIndex].count {
                backwardDiagonals[rowIndex - columnIndex + count - 1] += String(
                    self[rowIndex][columnIndex]
                )
            }
        }
        return backwardDiagonals
    }
}
