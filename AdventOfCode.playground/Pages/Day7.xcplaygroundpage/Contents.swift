import Foundation

let example = Day7(.example)
let puzzle = Day7(.puzzle)

print("Day 7")
print("------")

// MARK: - Part 1

let partOneExampleSolution = 3749

let partOneExampleResult = example.solvePartOne()

let partOneResult = puzzle.solvePartOne()

print("Part 1: \(partOneResult)")

// MARK: - Part 2

//let partTwoExampleSolution = 6

//let partTwoExampleResult = example.solvePartTwo()

//let partTwoResult = puzzle.solvePartTwo()

//print("Part 2: \(partTwoResult)\n")

// MARK: -

class Day7: Puzzle<Calibrations>, Solvable {
    override public var puzzleFile: String { #file }

    func solvePartOne() -> Int {
        input.calibrations
            .filter { $1.evaluates(to: $0) }
            .keys
            .reduce(0, +)
    }

    func solvePartTwo() -> Int {
        0
    }
}

struct Calibrations: Parsable {
    var calibrations: [Int: [Int]] = [:]

    init(from file: String) {
        getRawText(from: file)
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }
            .forEach {
                let components = $0.components(separatedBy: ":")
                if let key = Int(components[0]) {
                    calibrations[key] = components[1]
                        .components(separatedBy: " ")
                        .compactMap { Int($0) }
                }
            }
    }
}

extension [Int] {
    func evaluates(to target: Int) -> Bool {
        if count == 1, let first {
            return first == target
        }

        return !Operation.allCases.filter {
            var copy = self
            let partialResult = copy.removeFirst()

            switch $0 {
            case .add:
                copy[0] += partialResult
            case .multiply:
                copy[0] *= partialResult
            }

            return copy.evaluates(to: target)
        }
        .isEmpty
    }

    func isSolution(to target: Int) -> Bool {
        guard count == 1, let first else { return false }
        return first == target
    }
}

enum Operation: CaseIterable {
    case add
    case multiply
}
