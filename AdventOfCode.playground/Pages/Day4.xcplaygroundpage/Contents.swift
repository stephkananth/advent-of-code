import Foundation

let example = Day4(.example)
let puzzle = Day4(.puzzle)

print("Day 4")
print("------")

// MARK: - Part 1

let partOneExampleSolution = 18

let partOneExampleResult = example.solvePartOne()

if partOneExampleResult == partOneExampleSolution {
    puzzle.partOne()
}

// MARK: - Part 2

let partTwoExampleSolution = 9

let partTwoExampleResult = example.solvePartTwo()

if partTwoExampleResult == partTwoExampleSolution {
    puzzle.partTwo()
}
