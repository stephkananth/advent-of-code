//
//  Program.swift
//  
//
//  Created by Stephanie Ananth on 12/3/24.
//

import Foundation

public struct Program: Parsable, Programmable {
    public private(set) var program: [[Int]] = []

    public init(from file: String) {
        program = getRawText(from: file).program
    }
}
