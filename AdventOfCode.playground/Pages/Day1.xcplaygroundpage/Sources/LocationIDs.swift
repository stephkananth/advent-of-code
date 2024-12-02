//
//  LocationIDs.swift
//
//
//  Created by Stephanie Ananth on 12/1/24.
//

import Foundation

public struct LocationIDs: Inputable {
    public private(set) var count: Int = 0
    public private(set) var left: [Int] = []
    public private(set) var right: [Int] = []

    public init(from file: String) {
        do {
            let rawText = try String(contentsOf: getURL(from: file), encoding: .utf8)
            let regex = /(?:(\d+)(?:\s{3})(\d+)(?:\n?))/

            rawText.matches(of: regex).forEach { match in
                if let left = Int(match.1), let right = Int(match.2) {
                    self.count += 1
                    self.left.append(left)
                    self.right.append(right)
                }
            }
        } catch {
            fatalError(error.localizedDescription)
        }

        left.sort()
        right.sort()
    }
}
