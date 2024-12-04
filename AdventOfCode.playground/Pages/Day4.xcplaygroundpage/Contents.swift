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

let partTwoExampleSolution = 9

let partTwoExampleResult = example.solvePartTwo()

let partTwoResult = puzzle.solvePartTwo()

print("Part 2: \(partTwoResult)\n")

class Day4: Puzzle<WordSearch>, Solvable {
    override public var puzzleFile: String { #file }

    func solvePartOne() -> Int {
        input.strings.reduce(0) { $0 + $1.xmasCount }
    }

    func solvePartTwo() -> Int {
        input.wordSearch.xmasShapeCount
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
            .compactMap { $0.isEmpty ? nil : $0 }
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

    var xmasShapeCount: Int {
        var xmasShapeCount = 0

        guard let first else { return 0 }

        let rows = count
        let columns = first.count

        guard rows > 2, columns > 2 else { return 0 }

        for row in 0..<(rows - 2) {
            for column in 0..<(columns - 2) {

                let temp = [
                    [self[row][column], self[row][column + 1], self[row][column + 2]],
                    [self[row + 1][column], self[row + 1][column + 1], self[row + 1][column + 2]],
                    [self[row + 2][column], self[row + 2][column + 1], self[row + 2][column + 2]]
                ]

                if temp.isXmasShape {
                    xmasShapeCount += 1
                }
            }
        }

        return xmasShapeCount
    }

    var isXmasShape: Bool {
        guard let first else { return false }

        let rows = count
        let columns = first.count

        guard rows == 3, columns == 3 else { return false }

        guard self[1][1] == "A" else { return false }

        var forwardDiagonal: String = ""
        forwardDiagonal += String(self[2][0])
        forwardDiagonal += String(self[1][1])
        forwardDiagonal += String(self[0][2])

        guard forwardDiagonal == "MAS" || forwardDiagonal == "SAM" else { return false }

        var backwardDiagonal: String = ""
        backwardDiagonal += String(self[0][0])
        backwardDiagonal += String(self[1][1])
        backwardDiagonal += String(self[2][2])

        guard backwardDiagonal == "MAS" || backwardDiagonal == "SAM" else { return false }

        return true
    }
}
