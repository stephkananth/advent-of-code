//
//  Puzzle.swift
//  
//
//  Created by Stephanie Ananth on 12/1/24.
//

public protocol Puzzle {
    associatedtype OutputType: Equatable

    var inputType: InputType { get }

    func solve() -> OutputType

    static func solve(inputType: InputType) -> OutputType
}
