//
//  Character+Day8.swift
//  
//
//  Created by Stephanie Ananth on 12/9/24.
//

import Foundation

extension Character {
    var antenna: Antenna? {
        switch self {
        case ".": return nil
        case "#": return .antinode
        default: return .node(self)
        }
    }
}
