//
//  Day8.swift
//
//
//  Created by Stephanie Ananth on 12/9/24.
//

import Foundation

public class Day8: Puzzle<Roof>, Solvable {
    override public var puzzleFile: String { #file }

    public func solvePartOne() -> Int {
        solve { i, j in
            [2 * i - j, 2 * j - i]
        }
    }

    public func solvePartTwo() -> Int {
        solve(with: input.roof.inLine)
    }

    private func solve(
        with options: (RoofIndex, RoofIndex) -> [RoofIndex]
    ) -> Int {
        Set(
            input.roof.antennas.flatMap { (_, indexes) in
                indexes.flatMap { i in
                    indexes
                        .filter { i != $0 }
                        .flatMap { j in
                            options(i, j)
                                .filter { index in
                                    input.roof.isValid(index: index)
                                }
                        }
                }
            }
        )
        .count
    }
}
