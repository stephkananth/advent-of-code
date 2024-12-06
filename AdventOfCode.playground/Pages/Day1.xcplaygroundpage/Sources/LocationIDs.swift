//
//  LocationIDs.swift
//
//
//  Created by Stephanie Ananth on 12/1/24.
//

import Foundation

public struct LocationIDs: Parsable {
    private(set) var left: [Int] = []
    private(set) var right: [Int] = []

    public init(from file: String) {
        getRawText(from: file)
            .components(separatedBy: "\n")
            .forEach {
                let line = $0.components(separatedBy: "   ")
                if let left = Int(line[0]), let right = Int(line[1]) {
                    self.left.append(left)
                    self.right.append(right)
                }
            }

        left.sort()
        right.sort()
    }
}
