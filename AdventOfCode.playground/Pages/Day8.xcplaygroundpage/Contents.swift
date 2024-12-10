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
