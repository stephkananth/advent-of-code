import Foundation

let example = Day9(.example)
let puzzle = Day9(.puzzle)

print("Day 9")
print("------")

// MARK: - Part 1

let partOneExampleSolution = 1928

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

class Day9: Puzzle<DiskFragmenter>, Solvable {
    override public var puzzleFile: String { #file }

    func solvePartOne() -> Int {
        input.diskMap.compacted.checksum
    }

    func solvePartTwo() -> Int {
        return 0
    }
}

struct DiskFragmenter: Parsable {
    var diskMap: [Int?] = []

    init(from file: String) {
        diskMap = getRawText(from: file)
            .compactMap { Int("\($0)") }
            .enumerated()
            .flatMap { index, value in
                [Int?](repeating: index.isMultiple(of: 2) ? index / 2 : nil, count: value)
            }
    }
}

extension [Int] {
    var checksum: Int {
        enumerated().reduce(0) {
            $0 + ($1.offset * $1.element)
        }
    }
}


extension [Int?] {
    var compacted: [Int] {
        var (copy, count) = (self, count)
        for i in 0..<count {
            guard i < copy.count else { break }

            if (copy[i] == .none || copy[i] == nil),
               let lastIndex = copy.lastIndex(
                where: { $0 != .none && $0 != nil }
               ) {
                copy[i] = copy[lastIndex]
                copy.removeLast(copy.count - lastIndex)
            }
        }
        return copy.compactMap { $0 }
    }


    func prettyPrint() {
        print(reduce("") { $0 + "\($1 == nil ? "." : "\($1!)")" })
    }
}

extension [Int] {
    func prettyPrint() {
        print(reduce("") { $0 + "\($1)" })
    }
}
