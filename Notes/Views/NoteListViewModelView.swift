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

    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ScrollView {
                    PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                        viewModel.listNotes(completion: nil)
                    }
                    List {
                        ForEach(viewModel.notes, id: \.title) { note in
                            NoteRowView(note: note)
                        }
                        .onDelete(perform: delete(at:))
                    }
                    .navigationTitle("Notes")
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button(action: {
                                withAnimation {
                                    titleAlertInput = ""
                                    contentAlertInput = ""
                                    self.isShowingAlert.toggle()
                                }
                            }) {
                                Text("Add")
                            }
                        }
                    }.frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                }.coordinateSpace(name: "pullToRefresh")
            }
        }.textFieldAlert(isShowing: $isShowingAlert,
                         titleTextField: $titleAlertInput,
                         descriptionTextField: $contentAlertInput,
                         title: "Note title",
                         contentTitle: "Content",
                         viewModel: viewModel as! NoteListViewModel)
        
        .onAppear() {
            viewModel.listNotes(completion: nil)
        }
    }
    
    private func delete(at offsets: IndexSet) {
        viewModel.delete(at: offsets, completion: nil)
    }
    
    private func safeCast(viewModel: T) -> NoteListViewModel {
        return viewModel as! NoteListViewModel
    }
}


