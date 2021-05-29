//
//  Note.swift
//  Notes
//
//  Created by bruno on 23/05/21.
//

import SwiftUI
import CoreData

extension Note: Identifiable {
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
}
