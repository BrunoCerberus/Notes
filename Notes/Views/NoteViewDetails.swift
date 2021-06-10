//
//  NoteViewDetails.swift
//  Notes
//
//  Created by Jordan Cassiano on 10/06/21.
//

import SwiftUI

struct NoteViewDetails: View {
    var note: Note?

    @EnvironmentObject var viewModel: NoteListViewModel

    @State var title: String = ""

    @State var content: String = ""

    var body: some View {
        VStack {
            TextField("Title", text: $title)
                .frame(height: 60)


            TextField("Content", text: $content)
                .frame(height: 60)


            Button(action: {
                viewModel.save(note: .init(title: title, content: content), completion: {
                    print("Salvou")

                    
                })
            }) {
                Text("save")
                    .frame(width: 200, height: 60)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .onAppear {
            title = note?.title ?? ""
            content = note?.content ?? ""
        }
    }
}

struct NoteViewDetails_Previews: PreviewProvider {
    static var previews: some View {
        NoteViewDetails()
    }
}
