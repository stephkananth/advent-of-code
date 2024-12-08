import Foundation

let example = Day7(.example)
let puzzle = Day7(.puzzle)

print("Day 7")
print("------")

// MARK: - Part 1

let partOneExampleSolution = 3749

let partOneExampleResult = example.solvePartOne()

if partOneExampleResult == partOneExampleSolution {
    puzzle.partOne()
}

// MARK: - Part 2

let partTwoExampleSolution = 11387

let partTwoExampleResult = example.solvePartTwo()

if partTwoExampleResult == partTwoExampleSolution {
    puzzle.partTwo()
}
