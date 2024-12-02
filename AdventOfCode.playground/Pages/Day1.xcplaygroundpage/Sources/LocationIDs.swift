//
//  LocationIDs.swift
//
//
//  Created by Stephanie Ananth on 12/1/24.
//

import Foundation

public struct LocationIDs: Inputtable {
    private(set) var count: Int = 0
    private(set) var left: [Int] = []
    private(set) var right: [Int] = []

    public init(from file: String) {
        getRawText(from: file).components(separatedBy: "\n").forEach { line in
            let components = line.components(separatedBy: "   ")
            if let left = Int(components[0]), let right = Int(components[1]) {
                self.count += 1
                self.left.append(left)
                self.right.append(right)
            }
        }

        left.sort()
        right.sort()
    }
}
