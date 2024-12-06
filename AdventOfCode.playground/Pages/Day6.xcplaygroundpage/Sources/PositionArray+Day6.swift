//
//  PositionArray+Day6.swift
//
//
//  Created by Stephanie Ananth on 12/6/24.
//

import Foundation

extension [Position] {
    var visitedCount: Int {
        filter(\.isVisited).count
    }
}
