//
//  NoteListView.swift
//  Notes
//
//  Created by bruno on 24/05/21.
//

import SwiftUI

struct NoteListView: View {
    var body: some View {
        NoteListViewModelView(viewModel: NoteListViewModel())
    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        NoteListView()
            .preferredColorScheme(.dark)
    }
}
