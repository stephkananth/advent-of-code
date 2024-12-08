//
//  Date+Utilities.swift
//
//
//  Created by Stephanie Ananth on 12/7/24.
//

import Foundation

extension Date {
    var elapsed: String {
        String(format: "%.2f", Date().timeIntervalSince(self))
    }
}
