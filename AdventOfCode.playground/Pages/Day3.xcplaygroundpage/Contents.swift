import Foundation

let example = Day3(.example)
let puzzle = Day3(.puzzle)

print("Day 3")
print("------")

// MARK: - Part 1

let partOneExampleSolution = 161

let partOneExampleResult = example.solvePartOne()

let partOneResult = puzzle.solvePartOne()

print("Part 1: \(partOneResult)")

// MARK: - Part 2

let partTwoExampleSolution = 48

let partTwoExampleResult = example.solvePartTwo()

let partTwoResult = puzzle.solvePartTwo()

print("Part 2: \(partTwoResult)\n")

class Day3: Puzzle<Program>, Solvable {
    override public var puzzleFile: String { #file }

    func solvePartOne() -> Int {
        input.memory.reduce(0) { $0 + $1[0] * $1[1] }
    }

    func solvePartTwo() -> Int {
        Day3Part2(inputType).solvePartTwo()
    }
}

struct Program: Parsable {
    private(set) var memory = [[Int]]()

    init(from file: String) {
        memory = getRawText(from: file).program
    }
}

class Day3Part2: Puzzle<ConditionalProgram>, Solvable {
    override public var puzzleFile: String { "Day3Part2.swift" }

    func solvePartOne() -> Int {
        fatalError()
    }

    func solvePartTwo() -> Int {
        input.memory.reduce(0) { $0 + $1[0] * $1[1] }
    }
}

struct ConditionalProgram: Parsable {
    private(set) var memory = [[Int]]()

    init(from file: String) {
        memory = getRawText(from: file)
            .components(separatedBy: "do()")
            .map { $0.components(separatedBy: "don't()") }
            .compactMap(\.first)
            .joined()
            .program
    }
}

fileprivate extension String {
    var program: [[Int]] {
        let regex = /(?:mul\()(\d{1,3})(?:,)(\d{1,3})(?:\))/
        return matches(of: regex).compactMap { match in
            guard let left = Int(match.1), let right = Int(match.2) else { return nil }
            return [left, right]
        }
    }
}
