//
//  NoteListViewModel.swift
//  Notes
//
//  Created by bruno on 24/05/21.
//

import Foundation
import SwiftUI

protocol NoteListViewModelProtocol: ObservableObject {
    var notes: [Note] { get }
    func listNotes(completion: (() -> Void)?)
    func save(note: Note, completion: (() -> Void)?)
}

extension NoteListViewModelProtocol {
    var notes: [Note] {
        get { [Note]() }
    }
    func listNotes(completion: (() -> Void)?) { }
}

final class NoteListViewModel: NoteListViewModelProtocol {
    
    @Published var notes: [Note] = [Note]()
    
    let api: NotesAPIProtocol
    
    init(api: NotesAPIProtocol = NotesAPI()) {
        self.api = api
    }
    
    func listNotes(completion: (() -> Void)?) {
        api.getNotes(completion: { [weak self] notes, result in
            self?.notes = notes ?? []
            completion?()
        })
    }
    
    func save(note: Note, completion: (() -> Void)?) {
        api.save(note: note, completion: { [weak self] note, result in
            if let note: Note = note {
                self?.notes.append(note)
            }
            completion?()
        })
    }
}
