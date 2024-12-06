import Foundation

let example = Day5(.example)
let puzzle = Day5(.puzzle)

print("Day 5")
print("------")

// MARK: - Part 1

let partOneExampleSolution = 143

let partOneExampleResult = example.solvePartOne()

let partOneResult = puzzle.solvePartOne()

print("Part 1: \(partOneResult)")

// MARK: - Part 2

let partTwoExampleSolution = 123

let partTwoExampleResult = example.solvePartTwo()

let partTwoResult = puzzle.solvePartTwo()

print("Part 2: \(partTwoResult)\n")

class Day5: Puzzle<PrintQueue>, Solvable {
    override public var puzzleFile: String { #file }

    func solvePartOne() -> Int {
        input.updates.reduce(0) {
            $0 + ($1.isInOrder(rules: input.rules) ? $1.middleNumber : 0)
        }
    }

    func solvePartTwo() -> Int {
        input.updates
            .filter { !$0.isInOrder(rules: input.rules) }
            .map { $0.ordered(by: input.rules).middleNumber }
            .reduce(0, +)
    }
}

struct PrintQueue: Parsable {
    var rules: [Int: (before: Set<Int>, after: Set<Int>)] = [:]
    var updates: [[Int]] = []

    init(from file: String) {
        let components = getRawText(from: file).components(separatedBy: "\n\n")

        components[0]
            .components(separatedBy: "\n")
            .forEach { rawRule in
                let line = rawRule.components(separatedBy: "|")
                if let left = Int(line[0]), let right = Int(line[1]) {
                    if !rules.keys.contains(left) {
                        rules[left] = (before: [], after: [right])
                    } else {
                        rules[left]?.after.insert(right)
                    }

                    if !rules.keys.contains(right) {
                        rules[right] = (before: [left], after: [])
                    } else {
                        rules[right]?.before.insert(left)
                    }
                }
            }

        updates = components[1]
            .components(separatedBy: "\n")
            .map { $0.components(separatedBy: ",").compactMap { Int($0) } }
            .filter { !$0.isEmpty }
    }
}

extension [Int] {
    var middleNumber: Int {
        self[count / 2]
    }

    func isInOrder(rules: [Int: (before: Set<Int>, after: Set<Int>)]) -> Bool {
        for (index, value) in enumerated() {
            if let rule = rules[value] {
                let afterValues = rule.after
                for beforeIndex in 0..<index {
                    if afterValues.contains(self[beforeIndex]) {
                        return false
                    }
                }

                let beforeValues = rule.before
                for afterIndex in (index + 1)..<count {
                    if beforeValues.contains(self[afterIndex]) {
                        return false
                    }
                }
            }
        }
        return true
    }

    func ordered(by rules: [Int: (before: Set<Int>, after: Set<Int>)]) -> [Int] {
        compactMap {
            if let before = rules[$0]?.before, let after = rules[$0]?.after {
                return Rule(id: $0, before: before, after: after)
            }
            return nil
        }
        .sorted()
        .map(\.id)
    }
}

struct Rule: Comparable, Equatable, Identifiable {
    let id: Int
    let before: Set<Int>
    let after: Set<Int>

    static func < (lhs: Rule, rhs: Rule) -> Bool {
        lhs.after.contains(rhs.id)
    }
}

