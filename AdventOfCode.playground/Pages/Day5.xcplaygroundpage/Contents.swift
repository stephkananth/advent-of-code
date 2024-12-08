import Foundation

let example = Day5(.example)
let puzzle = Day5(.puzzle)

print("Day 5")
print("------")

// MARK: - Part 1

let partOneExampleSolution = 143

let partOneExampleResult = example.solvePartOne()

if partOneExampleResult == partOneExampleSolution {
    puzzle.partOne()
}

// MARK: - Part 2

let partTwoExampleSolution = 123

let partTwoExampleResult = example.solvePartTwo()

if partTwoExampleResult == partTwoExampleSolution {
    puzzle.partTwo()
}
