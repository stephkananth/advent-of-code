//
//  String+Day3.swift
//  
//
//  Created by Stephanie Ananth on 12/3/24.
//

import Foundation

public extension String {
    var program: [[Int]] {
        let regex = /(?:mul\()(\d{1,3})(?:,)(\d{1,3})(?:\))/
        return matches(of: regex).compactMap { match in
            guard let left = Int(match.1), let right = Int(match.2) else { return nil }
            return [left, right]
        }
    }
}
