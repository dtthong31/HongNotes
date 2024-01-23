//
//  NewNoteView.swift
//  Hong Notes
//
//  Created by dtthong on 19/01/2024.
//

import SwiftUI

struct NoteView: View {
    @State
    private var noteTitle: String = ""
    @State
    private var noteContent: String = ""
    @Environment(\.presentationMode)
    var presentationMode
    @StateObject
    var viewModel = NoteModel()
    
    var userId: String
    var note: Note?
    
    var body: some View {
        VStack {
            TextField("Title", text: $noteTitle).padding(.leading, 10)
            
            TextEditor(text: $noteContent)
                .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .padding(.top, 0)
                    .padding(.bottom, 10)

            Spacer()
        }
        .onAppear {
            if let existingNote = note {
                noteTitle = existingNote.title
                noteContent = existingNote.content
            }
        }
        .navigationBarTitle(note == nil ? "New note" :note!.title, displayMode: .inline).frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarItems(
            leading:
            Button(action: {
                saveNote()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Save")
                }.navigationBarBackButtonHidden()
            })
    }

    func extractTitle(from content: String) -> String {
        let lines = content.split(separator: "\n", maxSplits: 1, omittingEmptySubsequences: true)
        return lines.first.map(String.init) ?? "New Note"
    }
    
    func saveNote() {
        if let note = note, note.id != "" {
            let updateNote = Note(id: note.id,title: noteTitle, content: noteContent)
            viewModel.updateNote(userId: self.userId, note: updateNote, completion: { err in
                if (err != nil) {
                    print(err ?? "")
                } else {
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
        } else {
            let newNote = Note(id: UUID().uuidString,title: noteTitle, content: noteContent)
            if newNote.title != "" || newNote.content != "" {
                viewModel.createNote(userId: self.userId, note: newNote) {
                   self.presentationMode.wrappedValue.dismiss()
                }
            } else {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
       
    }
}

struct NewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        return NoteView(userId: "1",note: Note(id: "12345", title: "Maket", content: "vegetable"))
    }
}
