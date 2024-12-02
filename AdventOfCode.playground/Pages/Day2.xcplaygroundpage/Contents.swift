import Foundation

// MARK: - Part 1

let partOneExampleSolution = 2

let partOneExampleResult = Day2(.example).solvePartOne()

let partOneResult = Day2(.puzzle).solvePartOne()

print("part 1: \(partOneResult)")

// MARK: - Part 2

let partTwoExampleSolution = 4

let partTwoExampleResult = Day2(.example).solvePartTwo()

let partTwoResult = Day2(.puzzle).solvePartTwo()

print("part 2: \(partTwoResult)")

struct Day2: Puzzlable {
    let puzzleFile = #file
    let inputType: InputType

    public init(_ inputType: InputType) {
        self.inputType = inputType
    }

    func solvePartOne() -> Int {
        Reports(from: inputFile).reports.filter(\.isSafe).count
    }

    func solvePartTwo() -> Int {
        Reports(from: inputFile).reports.filter(\.couldBeSafe).count
    }
}

struct Reports: Inputable {
    var reports = [[Int]]()

    init(from file: String) {
        let rawText = getRawText(from: file)
        reports = rawText.components(separatedBy: "\n")
            .compactMap { rawReport in
                rawReport.components(separatedBy: " ").compactMap { rawLevel in
                    Int(rawLevel)
                }
            }
            .filter { !$0.isEmpty }
    }
}

fileprivate extension [Int] {
    var isSafe: Bool {
        guard count > 1 else { return true }

        let firstDiff = self[1] - self[0]
        if abs(firstDiff) < 1 || abs(firstDiff) > 3 { return false }
        let isIncreasing = firstDiff > 0

        for i in (2..<count) {
            let diff = self[i] - self[i - 1]
            if abs(diff) < 1 || abs(diff) > 3 { return false }
            if (isIncreasing && diff < 0) || (!isIncreasing && diff > 0) {
                return false
            }
        }
        return true
    }

    var couldBeSafe: Bool {
        var copy = self
        for i in (0..<count) {
            copy.remove(at: i)
            if copy.isSafe { return true }
            copy = self
        }
        return false
    }
}
