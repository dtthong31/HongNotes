//
//  HomeModel.swift
//  Hong Notes
//
//  Created by dtthong on 19/01/2024.
//

import Foundation
class ListNoteModel: ObservableObject {
    @Published
    var note: Note?
    @Published
    var notes = [Note]()
    
    var noteService = NoteService()
    
    init(userId: String){
        getNotes(userId: userId)
    }
    
    func getNotes(userId: String) {
        guard userId != "" else {return}
        noteService.fetchNotes(userId: userId) {
            self.notes = self.noteService.notes
        }
    }
}
