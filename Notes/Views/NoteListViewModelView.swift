//
//  NoteListViewModelView.swift
//  Notes
//
//  Created by bruno on 25/05/21.
//

import SwiftUI

struct NoteListViewModelView<T>: View where T: NoteListViewModelProtocol {
    @ObservedObject var viewModel: T

    @State private var isShowingAlert: Bool = false
    @State private var titleAlertInput: String = ""
    @State private var contentAlertInput: String = ""
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ScrollView {
                    PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                        viewModel.listNotes(completion: nil)
                    }

                    VStack {
                        Button(action: { isPresented.toggle() }) {
                            Text("Favoritos")
                        }
                    }

                    List {
                        ForEach(viewModel.notes, id: \.id) { note in
                            NavigationLink(
                                destination: NoteViewDetails(note: note),
                                label: {
                                    NoteRowView(note: note)
                                })
//                                .onTapGesture {
//                                    print(note)
//                                    self.insert(note: note)
//                                }textFieldAlert
                        }
                        .onDelete(perform: delete)
                    }
                    .navigationTitle("Notes")
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            NavigationLink(
                                destination: NoteViewDetails(),
                                label: {
                                    Text("Add")
                                })
                        }
                    }
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                }
                .coordinateSpace(name: "pullToRefresh")
            }
        }
        .onAppear() {
            viewModel.listNotes(completion: nil)
        }
        .sheet(isPresented: $isPresented, content: {
            VStack {
                Text("Favoritos")
                List {
                    ForEach(viewModel.favoritesNotes, id: \.id) { note in
                        NoteRowView(note: note)
                    }
                }
            }
        })
    }
    
    private func delete(offsets: IndexSet) {
        viewModel.delete(at: offsets, completion: nil)
    }
    
    private func insert(note: Note) {
        viewModel.insert(note: note)
    }
}


