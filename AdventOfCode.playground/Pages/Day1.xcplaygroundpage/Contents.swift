import Foundation

let example = Day1(.example)
let puzzle = Day1(.puzzle)

print("Day 1")
print("------")

// MARK: - Part 1

let partOneExampleSolution = 11

let partOneExampleResult = example.solvePartOne()

if partOneExampleResult == partOneExampleSolution {
    puzzle.partOne()
}

// MARK: - Part 2

let partTwoExampleSolution = 31

let partTwoExampleResult = example.solvePartTwo()

if partTwoExampleResult == partTwoExampleSolution {
    puzzle.partTwo()
}
