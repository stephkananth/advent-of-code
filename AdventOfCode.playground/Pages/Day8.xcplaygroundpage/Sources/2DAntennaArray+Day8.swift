//
//  2DAntennaArray+Day8.swift
//
//
//  Created by Stephanie Ananth on 12/9/24.
//

import Foundation

extension [[Antenna?]] {
    var maxRow: Int {
        count - 1
    }

    var maxColumn: Int {
        (first?.count ?? 0) - 1
    }

    func isValid(index: RoofIndex) -> Bool {
        let (row, column) = (index.row, index.column)
        guard row >= 0, column >= 0, row <= maxRow, column <= maxColumn else {
            return false
        }
        return true
    }

    var antennas: [Antenna: [RoofIndex]] {
        var antennas: [Antenna: [RoofIndex]] = [:]
        for row in 0..<count {
            for column in 0..<self[row].count {
                if let antenna = self[row][column] {
                    let index = RoofIndex(row: row, column: column)
                    if antennas.keys.contains(antenna) {
                        antennas[antenna]?.append(index)
                    } else {
                        antennas[antenna] = [index]
                    }
                }
            }
        }
        return antennas
    }

    func inLine(index1: RoofIndex, index2: RoofIndex) -> [RoofIndex] {
        let difference = index2 - index1
        var indexes: [RoofIndex] = []

        var additiveIndex = index1
        while isValid(index: additiveIndex) {
            indexes.append(additiveIndex)
            additiveIndex += difference
        }

        var subtractiveIndex = index1
        while isValid(index: subtractiveIndex) {
            indexes.append(subtractiveIndex)
            subtractiveIndex -= difference
        }

        return indexes
    }
}
