//
//  NoteListViewModelView.swift
//  Notes
//
//  Created by bruno on 25/05/21.
//

import SwiftUI

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


