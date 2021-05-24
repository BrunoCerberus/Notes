//
//  NotesRow.swift
//  Notes
//
//  Created by bruno on 24/05/21.
//

import SwiftUI

struct NoteRowView: View {
    var note: NoteRow
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(note.title)
                Text(note.content).font(.subheadline).foregroundColor(.gray)
            }
        }
    }
}
