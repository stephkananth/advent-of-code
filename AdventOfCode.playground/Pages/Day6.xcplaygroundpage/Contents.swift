import Foundation

let example = Day6(.example)
let puzzle = Day6(.puzzle)

print("Day 6")
print("------")

// MARK: - Part 1

let partOneExampleSolution = 41

let partOneExampleResult = example.solvePartOne()

if partOneExampleResult == partOneExampleSolution {
    puzzle.partOne()
}

// MARK: - Part 2

let partTwoExampleSolution = 6

let partTwoExampleResult = example.solvePartTwo()

if partTwoExampleResult == partTwoExampleSolution {
    puzzle.partTwo()
}
