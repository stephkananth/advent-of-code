//
//  RoofIndex.swift
//
//
//  Created by Stephanie Ananth on 12/9/24.
//

import Foundation

struct RoofIndex: Equatable, Hashable {
    var row: Int
    var column: Int

    static func +(lhs: RoofIndex, rhs: RoofIndex) -> RoofIndex {
        RoofIndex(row: lhs.row + rhs.row, column: lhs.column + rhs.column)
    }

    static func -(lhs: RoofIndex, rhs: RoofIndex) -> RoofIndex {
        RoofIndex(row: lhs.row - rhs.row, column: lhs.column - rhs.column)
    }

    static func *(lhs: Int, rhs: RoofIndex) -> RoofIndex {
        RoofIndex(row: lhs * rhs.row, column: lhs * rhs.column)
    }

    static func +=(lhs: inout RoofIndex, rhs: RoofIndex) {
        lhs.row += rhs.row
        lhs.column += rhs.column
    }

    static func -=(lhs: inout RoofIndex, rhs: RoofIndex) {
        lhs.row -= rhs.row
        lhs.column -= rhs.column
    }
}
