//
//  String+Extensions.swift
//  Notes
//
//  Created by bruno on 30/05/21.
//

import Foundation

extension String {
    func containsOnlyLettersAndWhitespace() -> Bool {
        let allowed = CharacterSet.alphanumerics.union(.whitespaces)
        return unicodeScalars.allSatisfy(allowed.contains)
    }
}
