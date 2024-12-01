//
//  String+Utilities.swift
//
//
//  Created by Stephanie Ananth on 12/1/24.
//

import Foundation

public extension String {
    var id: String {
        (URL(filePath: self).lastPathComponent as NSString).deletingPathExtension
    }

    func getInputFile(for inputType: InputType) -> String {
        inputType.getFile(for: id)
    }
}
