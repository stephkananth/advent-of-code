//
//  Inputable.swift
//  
//
//  Created by Stephanie Ananth on 12/2/24.
//

import Foundation

public protocol Inputable {
    init(from file: String)
}

public extension InputModel {
    func getURL(from file: String) -> URL {
        guard let url = Bundle.main.url(forResource: file, withExtension: ".txt") else {
            fatalError("Unable to get url for file: \(file)")
        }
        return url
    }
}
