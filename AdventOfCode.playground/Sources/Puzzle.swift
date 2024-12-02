//
//  Puzzle.swift
//  
//
//  Created by Stephanie Ananth on 12/2/24.
//

import Foundation

open class Puzzle<Input: Parsable> {
    open var puzzleFile: String {
        fatalError("Must override puzzleFile to #file")
    }

    public private(set) var input: Input!

    private let inputType: InputType

    private var inputFile: String {
        puzzleFile.getInputFile(for: inputType)
    }

    public init(_ inputType: InputType) {
        self.inputType = inputType
        defer {
            self.input = Input(from: inputFile)
        }
    }
}
