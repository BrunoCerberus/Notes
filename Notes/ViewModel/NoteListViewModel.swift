//
//  NoteListViewModel.swift
//  Notes
//
//  Created by bruno on 24/05/21.
//

import Foundation
import SwiftUI
import CoreData

protocol NoteListViewModelProtocol: ObservableObject {
    var notes: [Note] { get }
    var favoritesNotes: [Note] {
        get
    }
    func listNotes(completion: (() -> Void)?)
    func save(note: Note, completion: (() -> Void)?)
    func delete(at offsets: IndexSet, completion: (() -> Void)?)

    func insert(note: Note)
}

extension NoteListViewModelProtocol {
    var notes: [Note] {
        get { [Note]() }
    }

    var favoritesNotes: [Note] {
        get { [Note]() }
        
    }
    func listNotes(completion: (() -> Void)?) { }
    func insert(note: Note) { }
}

final class NoteListViewModel: NoteListViewModelProtocol {
    
    private var viewContext: NSManagedObjectContext
    
    @Published var notes: [Note] = [Note]()

    @Published var favoritesNotes: [Note] = [Note]()
    
    let api: NotesAPIProtocol
    
    init(api: NotesAPIProtocol = NotesAPI(), viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        self.api = api
    }

    func insert(note: Note) {
        if !favoritesNotes.contains(note) {
            favoritesNotes.append(note)
        }
    }
    
    func listNotes(completion: (() -> Void)?) {
        api.getNotes(completion: { [weak self] notes, result in
            if let notes = notes {
                self?.notes = notes
                if self?.clean() ?? false {
                    self?.addItem(notes: notes)
                }
            } else {
                self?.notes = self?.fetchAllItems() ?? []
            }
            completion?()
        })
    }
    
    func save(note: Note, completion: (() -> Void)?) {
        api.save(note: note, completion: { [weak self] note, result in
            if let note: Note = note {
                self?.notes.append(note)
                self?.addItem(note: note)
            }
            completion?()
        })
    }
    
    func delete(at offsets: IndexSet, completion: (() -> Void)?) {
        var selectedNote: Note = Note()
        var selectedIndex: Int = 0
        offsets.forEach { index in
            selectedNote = notes[index]
            selectedIndex = index
        }
        api.delete(noteId: selectedNote.id, completion: { [weak self] deleted in
            if deleted {
                self?.notes.remove(at: selectedIndex)
                self?.deleteItems(offsets: offsets)
            }
            completion?()
        })
    }
    
    private func fetchAllItems() -> [Note] {
        var notes: [Note] = []
        
        fetchObjects().forEach {
            var note: Note = Note()
            note.id = $0.id ?? ""
            note.title = $0.title ?? ""
            note.content = $0.content ?? ""
            notes.append(note)
        }
        
        return notes
    }
    
    private func addItem(notes: [Note]) {
        withAnimation {
            notes.forEach {
                let newItem = Item(context: viewContext)
                newItem.id = $0.id
                newItem.title = $0.title
                newItem.content = $0.content
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
    }
    
    private func clean() -> Bool {
        let context = viewContext
        let delete = NSBatchDeleteRequest(fetchRequest: Item.fetchRequest())
        
        do {
            try context.execute(delete)
            return true
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }
    
    private func addItem(note: Note) {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.id = note.id
            newItem.title = note.title
            newItem.content = note.content
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { fetchObjects()[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func fetchObjects() -> [Item] {
        let context = viewContext
        var items: [Item] = []
        
        do {
            items = try context.fetch(Item.fetchRequest())
            return items
        } catch let error {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
