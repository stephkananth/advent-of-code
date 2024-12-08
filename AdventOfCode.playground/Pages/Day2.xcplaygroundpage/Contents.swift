import Foundation

let example = Day2(.example)
let puzzle = Day2(.puzzle)

print("Day 2")
print("------")

// MARK: - Part 1

let partOneExampleSolution = 2

let partOneExampleResult = example.solvePartOne()

if partOneExampleResult == partOneExampleSolution {
    puzzle.partOne()
}

// MARK: - Part 2

let partTwoExampleSolution = 4

let partTwoExampleResult = example.solvePartTwo()

if partTwoExampleResult == partTwoExampleSolution {
    puzzle.partTwo()
}
