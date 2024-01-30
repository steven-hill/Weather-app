//
//  Extensions.swift
//  Weather app
//
//  Created by Steven Hill on 01/01/2024.
//

import Foundation

extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}

extension String {
    var capitaliseFirstLetterOnly: String {
        let firstLetter = self.prefix(1).capitalized
        let allOtherLetters = self.dropFirst().lowercased()
        return firstLetter + allOtherLetters
    }
}
