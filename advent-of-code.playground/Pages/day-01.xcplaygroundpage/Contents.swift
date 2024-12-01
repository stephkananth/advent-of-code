import Foundation

// MARK: - Day 1

let exampleSolution = 11

let exampleResult = Day1(.example).solve()

let result = Day1(.puzzle).solve()

print(result)

// MARK: - Solution

struct Day1: Puzzle {
    let puzzleFile = #file
    var inputType: InputType

    public init(_ inputType: InputType) {
        self.inputType = inputType
    }

    func solve() -> Int {
        let locationIds = LocationIDs(from: inputFile)
        return (0..<locationIds.count).reduce(into: 0) { partial, i in
            partial += abs(locationIds.left[i] - locationIds.right[i])
        }
    }
}
