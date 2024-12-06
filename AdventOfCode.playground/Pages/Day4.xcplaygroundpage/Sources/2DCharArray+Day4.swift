//
//  2DCharArray+Day4.swift
//
//
//  Created by Stephanie Ananth on 12/4/24.
//

import Foundation

extension [[Character]] {
    var rows: [String] {
        map { String($0) }
    }

    var columns: [String] {
        guard let first else { return [] }
        var columns = [String](repeating: "", count: first.count)
        for row in 0..<count {
            for column in 0..<self[row].count {
                columns[column] += String(self[row][column])
            }
        }
        return columns
    }

    var forwardDiagonals: [String] {
        guard let first else { return [] }
        var forwardDiagonals = [String](
            repeating: "",
            count: count + first.count - 1
        )
        for row in 0..<count {
            for column in 0..<self[row].count {
                forwardDiagonals[row + column] += String(self[row][column])
            }
        }
        return forwardDiagonals
    }

    var backwardDiagonals: [String] {
        guard let first else { return [] }
        var backwardDiagonals = [String](
            repeating: "",
            count: count + first.count - 1
        )
        for row in 0..<count {
            for column in 0..<self[row].count {
                backwardDiagonals[row - column + count - 1] += String(
                    self[row][column]
                )
            }
        }
        return backwardDiagonals
    }

    var xmasShapeCount: Int {
        guard let first else { return 0 }
        let (rows, columns) = (count, first.count)

        return (0..<(rows - 2))
            .reduce(0) { partialResult, row in
                partialResult + (0..<(columns - 2)).filter { column in
                    [
                        [
                            self[row][column],
                            self[row][column + 1],
                            self[row][column + 2]
                        ],
                        [
                            self[row + 1][column],
                            self[row + 1][column + 1],
                            self[row + 1][column + 2]
                        ],
                        [
                            self[row + 2][column],
                            self[row + 2][column + 1],
                            self[row + 2][column + 2]
                        ]
                    ].isXmasShape
                }.count
            }
    }

    private var isXmasShape: Bool {
        guard self[1][1] == "A" else { return false }

        let forwardDiagonal = "\(self[2][0])\(self[0][2])"
        guard forwardDiagonal == "MS" || forwardDiagonal == "SM" else {
            return false
        }

        let backwardDiagonal = "\(self[0][0])\(self[2][2])"
        guard backwardDiagonal == "MS" || backwardDiagonal == "SM" else {
            return false
        }

        return true
    }
}
