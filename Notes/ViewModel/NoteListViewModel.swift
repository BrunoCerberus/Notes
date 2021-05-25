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
}

extension NoteListViewModelProtocol {
    var notes: [Note] {
        get { [Note]() }
    }
    func listNotes(completion: (() -> Void)?) { }
}

struct NoteListViewModelView<T>: View where T: NoteListViewModelProtocol {
    @ObservedObject var viewModel: T

    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ScrollView {
                    PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                        viewModel.listNotes(completion: nil)
                    }
                    List(viewModel.notes, id: \.title) { note in
                        NoteRowView(note: note)
                    }
                    .navigationTitle("Notes")
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                print("add button taped")
                            }
                        }
                    }.frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                }.coordinateSpace(name: "pullToRefresh")
            }
        }
        .onAppear() {
            viewModel.listNotes(completion: nil)
        }
    }
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
}
