//
//  Calibrations.swift
//
//
//  Created by Stephanie Ananth on 12/7/24.
//

import Foundation

public struct Calibrations: Parsable {
    private(set) var calibrations: [Int: [Int]] = [:]

    public init(from file: String) {
        getRawText(from: file)
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }
            .forEach {
                let components = $0.components(separatedBy: ":")
                if let key = Int(components[0]) {
                    calibrations[key] = components[1]
                        .components(separatedBy: " ")
                        .compactMap { Int($0) }
                }
            }
    }
}
