//
//  NoteListView.swift
//  Notes
//
//  Created by bruno on 24/05/21.
//

import SwiftUI

struct NoteListView: View {


    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NoteListViewModelView(viewModel: NoteListViewModel(viewContext: viewContext))
            .environmentObject(NoteListViewModel(viewContext: viewContext))
    }
}
