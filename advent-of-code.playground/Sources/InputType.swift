//
//  InputType.swift
//  
//
//  Created by Stephanie Ananth on 12/1/24.
//

public enum InputType: String, CaseIterable {
    case example = "example_inputs"
    case puzzle = "inputs"

    func getFile(for puzzleFile: String) -> String {
        "\(rawValue)/\(puzzleFile.id)"
    }
}
