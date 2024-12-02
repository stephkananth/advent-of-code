//
//  Solvable.swift
//
//
//  Created by Stephanie Ananth on 12/1/24.
//

import Foundation

public protocol Solvable {
    associatedtype Output: Equatable

    func solvePartOne() -> Output
    func solvePartTwo() -> Output
}
