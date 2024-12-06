//
//  String+Day3.swift
//
//
//  Created by Stephanie Ananth on 12/3/24.
//

import Foundation

public extension String {
    var program: [[Int]] {
        matches(of: /(?:mul\()(\d{1,3})(?:,)(\d{1,3})(?:\))/)
            .compactMap {
                if let left = Int($0.1), let right = Int($0.2) {
                    return [left, right]
                }
                return nil
            }
    }
}
