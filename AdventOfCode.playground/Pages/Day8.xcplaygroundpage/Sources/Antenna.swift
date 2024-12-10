//
//  Antenna.swift
//
//
//  Created by Stephanie Ananth on 12/9/24.
//

import Foundation

enum Antenna: Hashable {
    case node(Character)
    case antinode
}

extension Character {
    var antenna: Antenna? {
        switch self {
        case ".": return nil
        case "#": return .antinode
        default: return .node(self)
        }
    }
}
