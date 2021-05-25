//
//  NoteListViewModel.swift
//  Notes
//
//  Created by bruno on 24/05/21.
//

protocol NoteListViewModelProtocol {
    var notes: [Note] { get }
}

final class NoteListViewModel: NoteListViewModelProtocol {
    
    private let api: NotesAPIProtocol
    
    var notes: [Note] {
        return
            [
                Note(title: "Note 1", content: "Content 1Content 1Content 1Content 1Content 1Content 1Content 1Content 1"),
                Note(title: "Note 2", content: "Content 2"),
                Note(title: "Note 3", content: "Content 3"),
                Note(title: "Note 4", content: "Content 4"),
                Note(title: "Note 5", content: "Content 5"),
            ]
    }
    
    init(api: NotesAPIProtocol = NotesAPI()) {
        self.api = api
    }
}
