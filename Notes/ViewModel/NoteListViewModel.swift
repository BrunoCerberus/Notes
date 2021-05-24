//
//  NoteListViewModel.swift
//  Notes
//
//  Created by bruno on 24/05/21.
//

protocol NoteListViewModelProtocol {
    var notes: [NoteRow] { get }
}

final class NoteListViewModel: NoteListViewModelProtocol {
    
    var notes: [NoteRow] {
        return
            [
                NoteRow(title: "Note 1", content: "Content 1"),
                NoteRow(title: "Note 2", content: "Content 2"),
                NoteRow(title: "Note 3", content: "Content 3"),
                NoteRow(title: "Note 4", content: "Content 4"),
                NoteRow(title: "Note 5", content: "Content 5"),
            ]
    }
}
