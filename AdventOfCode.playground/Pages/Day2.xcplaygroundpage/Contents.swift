import Foundation

// MARK: - Part 1

let partOneExampleSolution = 2

let partOneExampleResult = Day2(.example).solvePartOne()

//let partOneResult = Day2(.puzzle).solvePartOne()
//
//print("part 1: \(partOneResult)")

// MARK: - Part 2
//
//let partTwoExampleSolution = 31
//
//let partTwoExampleResult = Day2(.example).solvePartTwo()
//
//let partTwoResult = Day2(.puzzle).solvePartTwo()
//
//print("part 2: \(partTwoResult)")


struct Day2: Puzzle {
    let puzzleFile = #file
    let inputType: InputType

    public init(_ inputType: InputType) {
        self.inputType = inputType
    }

    func solvePartOne() -> Int {
        0
    }

    func solvePartTwo() -> Int {
        0
    }
}
