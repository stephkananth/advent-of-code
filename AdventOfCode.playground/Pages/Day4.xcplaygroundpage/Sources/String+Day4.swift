//
//  String+Day4.swift
//  
//
//  Created by Stephanie Ananth on 12/4/24.
//

import Foundation

extension String {
    var xmasCount: Int {
        matches(of: /XMAS/).count + matches(of: /SAMX/).count
    }
}
