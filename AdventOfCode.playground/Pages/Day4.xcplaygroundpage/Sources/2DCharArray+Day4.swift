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
        for rowIndex in 0..<count {
            for columnIndex in 0..<self[rowIndex].count {
                columns[columnIndex] += String(self[rowIndex][columnIndex])
            }
        }
        return columns
    }

    var forwardDiagonals: [String] {
        guard let first else { return [] }
        var forwardDiagonals = [String](repeating: "", count: count + first.count - 1)
        for rowIndex in 0..<count {
            for columnIndex in 0..<self[rowIndex].count {
                forwardDiagonals[rowIndex + columnIndex] += String(self[rowIndex][columnIndex])
            }
        }
        return forwardDiagonals
    }

    var backwardDiagonals: [String] {
        guard let first else { return [] }
        var backwardDiagonals = [String](repeating: "", count: count + first.count - 1)
        for rowIndex in 0..<count {
            for columnIndex in 0..<self[rowIndex].count {
                backwardDiagonals[rowIndex - columnIndex + count - 1] += String(
                    self[rowIndex][columnIndex]
                )
            }
        }
        return backwardDiagonals
    }

    var xmasShapeCount: Int {
        guard let first else { return 0 }

        let rows = count
        let columns = first.count

        guard rows > 2, columns > 2 else { return 0 }

        var xmasShapeCount = 0

        for row in 0..<(rows - 2) {
            for column in 0..<(columns - 2) {
                if [
                    [self[row][column], self[row][column + 1], self[row][column + 2]],
                    [self[row + 1][column], self[row + 1][column + 1], self[row + 1][column + 2]],
                    [self[row + 2][column], self[row + 2][column + 1], self[row + 2][column + 2]]
                ].isXmasShape {
                    xmasShapeCount += 1
                }
            }
        }

        return xmasShapeCount
    }

    var isXmasShape: Bool {
        guard self[1][1] == "A" else { return false }

        let forwardDiagonal = "\(self[2][0])\(self[0][2])"
        guard forwardDiagonal == "MS" || forwardDiagonal == "SM" else { return false }

        let backwardDiagonal = "\(self[0][0])\(self[2][2])"
        guard backwardDiagonal == "MS" || backwardDiagonal == "SM" else { return false }

        return true
    }
}
