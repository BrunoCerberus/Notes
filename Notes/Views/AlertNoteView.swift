//
//  AlertNoteView.swift
//  Notes
//
//  Created by bruno on 25/05/21.
//

import SwiftUI

struct AlertNoteView<Presenting>: View where Presenting: View {
    
    @ObservedObject var viewModel: NoteListViewModel
    @Binding var isShowing: Bool
    @Binding var titleTextField: String
    @Binding var descriptionTextField: String
    let presenting: Presenting
    let title: String
    let contentTitle: String
    
    var body: some View {
        GeometryReader { (deviceSize: GeometryProxy) in
            ZStack {
                presenting.disabled(isShowing)
                
                VStack {
                    Text(title).foregroundColor(.blue)
                    
                    TextField(titleTextField, text: $titleTextField)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .id(isShowing)
                        .foregroundColor(.black)
                        .onChange(of: titleTextField, perform: { newValue in
                            self.titleTextField = self.invalidateInput(newValue: newValue)
                        })
                    
                    Divider()
                    
                    Text(contentTitle).foregroundColor(.blue)
                    
                    TextField(descriptionTextField, text: $descriptionTextField)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .id(isShowing)
                        .foregroundColor(.black)
                        .onChange(of: descriptionTextField, perform: { newValue in
                            self.descriptionTextField = self.invalidateInput(newValue: newValue)
                        })
                    
                    Divider()
                    
                    HStack {
                        Button(action: {
                            withAnimation {
                                let note: Note = Note(title: titleTextField, content: descriptionTextField)
                                viewModel.save(note: note) {
                                    self.isShowing.toggle()
                                }
                            }
                        }) {
                            Text("Save")
                        }.disabled(titleTextField.isEmpty || descriptionTextField.isEmpty)
                    }
                }
                .padding()
                .background(Color.white)
                .frame(width: deviceSize.size.width * 0.7, height: deviceSize.size.height * 0.7)
                .shadow(radius: 1)
                .opacity(self.isShowing ? 1 : 0)
                .cornerRadius(10)
            }
        }
    }
    
    private func invalidateInput(newValue: String) -> String {
        if newValue.containsOnlyLettersAndWhitespace() {
            return newValue
        } else {
            var value = newValue
            value.removeLast()
            if value != newValue {
                return value
            }
        }
        return ""
    }
}

extension View  {
    func textFieldAlert(isShowing: Binding<Bool>,
                        titleTextField: Binding<String>,
                        descriptionTextField: Binding<String>,
                        title: String,
                        contentTitle: String,
                        viewModel: NoteListViewModel) -> some View {

        AlertNoteView(viewModel: viewModel, isShowing: isShowing,
                      titleTextField: titleTextField,
                      descriptionTextField: descriptionTextField,
                      presenting: self,
                      title: title,
                      contentTitle: contentTitle)
    }
}
