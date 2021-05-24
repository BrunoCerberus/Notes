//
//  NotesAPI.swift
//  Notes
//
//  Created by bruno on 23/05/21.
//

import Foundation
import SwiftGRPC

protocol NotesAPIProtocol {
    func getNotes(completion: @escaping([Note]?, CallResult?) -> Void)
    func save(note: Note, completion: @escaping(Note?, CallResult?) -> Void)
    func delete(noteId: String, completion: @escaping(Bool) -> ())
}

final class NotesAPI: NotesAPIProtocol {
    
    private let client = NoteServiceServiceClient.init(address: "127.0.0.1:50051", secure: false)
    
    func getNotes(completion: @escaping([Note]?, CallResult?) -> Void) {
        _ = try? client.list(Empty(), completion: { (notes, result) in
            DispatchQueue.main.async {
                completion(notes?.notes, result)
            }
        })
    }
    
    
    func save(note: Note, completion: @escaping(Note?, CallResult?) -> Void) {
        _ = try? client.insert(note, completion: { (createdNote, result) in
            DispatchQueue.main.async {
                completion(createdNote, result)
            }
        })
    }
    
    func delete(noteId: String, completion: @escaping(Bool) -> ()) {
        _ = try? client.delete(NoteRequestId(id: noteId), completion: { (success, result) in
            DispatchQueue.main.async {
                if let _ = success {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        })
    }
}
