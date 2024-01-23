//
//  NewNoteModel.swift
//  Hong Notes
//
//  Created by dtthong on 19/01/2024.
//

import Foundation


class NoteModel: ObservableObject {
    var noteService = NoteService()
    
    func createNote(userId: String, note: Note, completed: @escaping () -> Void) {
        noteService.createNote(forUserId: userId, newNote: note) {
            completed()
        }
    }
    
    func updateNote(userId: String, note: Note, completion: @escaping (Error?) -> Void) {
        noteService.updateNote(forUserId: userId, newNote: note) { err in
            completion(err)
        }
    }
}
