import Foundation

let example = Day3(.example)
let puzzle = Day3(.puzzle)

print("Day 3")
print("------")

// MARK: - Part 1

let partOneExampleSolution = 161

let partOneExampleResult = example.solvePartOne()

if partOneExampleResult == partOneExampleSolution {
    puzzle.partOne()
}

// MARK: - Part 2

let partTwoExampleSolution = 48

let partTwoExampleResult = example.solvePartTwo()

if partTwoExampleResult == partTwoExampleSolution {
    puzzle.partTwo()
}
