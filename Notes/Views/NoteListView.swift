//
//  NoteListView.swift
//  Notes
//
//  Created by bruno on 24/05/21.
//

import SwiftUI

struct NoteListView: View {
    
    var viewModel: NoteListViewModelProtocol
    
    var body: some View {
        NavigationView {
            List(viewModel.notes) { note in
                NoteRowView(note: note)
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        print("add button taped")
                    }
                    
                    Button("Help") {
                        print("Help tapped!")
                    }
                }
            }
        }
    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: NoteListViewModelProtocol = NoteListViewModel()
        NoteListView(viewModel: viewModel)
            .preferredColorScheme(.dark)
    }
}
