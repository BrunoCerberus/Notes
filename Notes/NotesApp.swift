//
//  NotesApp.swift
//  Notes
//
//  Created by bruno on 23/05/21.
//

import SwiftUI

@main
struct NotesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
