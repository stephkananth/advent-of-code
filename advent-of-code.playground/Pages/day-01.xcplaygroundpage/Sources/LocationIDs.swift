//
//  LocationIDs.swift
//
//
//  Created by Stephanie Ananth on 12/1/24.
//

import Foundation

public struct LocationIDs {
    public private(set) var count: Int = 0
    public private(set) var left: [Int] = []
    public private(set) var right: [Int] = []

    public init(from file: String) {
        guard let url = Bundle.main.url(forResource: file, withExtension: ".txt") else {
            print("Unable to get url for file: \(file)")
            return
        }

        do {
            let rawText = try String(contentsOf: url, encoding: .utf8)
            let regex = /(?:(\d+)(?:\s{3})(\d+)(?:\n))/

            rawText.matches(of: regex).forEach { match in
                if let left = Int(match.1), let right = Int(match.2) {
                    
                    self.left.append(left)
                    self.right.append(right)
                }
            }
        } catch {
            print(error)
        }

        left.sort()
        right.sort()
    }
}
