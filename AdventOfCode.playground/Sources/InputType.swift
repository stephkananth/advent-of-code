//
//  InputType.swift
//  
//
//  Created by Stephanie Ananth on 12/1/24.
//

import Foundation

public enum InputType: String, CaseIterable {
    case example = "ExampleInput"
    case puzzle = "Input"

    func getFile(for puzzleFile: String) -> String {
        "\(puzzleFile.id)+\(rawValue)"
    }
}
