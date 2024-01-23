//
//  NoteService.swift
//  Hong Notes
//
//  Created by dtthong on 19/01/2024.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class NoteService: ObservableObject {
    private var ref = Database.database().reference()
    @Published
    var notes = [Note]()
    @Published
    var note: Note?
    
    func fetchNotes(userId: String, completed: @escaping () -> Void) {
        ref.child("users").child(userId).child("notes").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let self = self else { return }
            
            var fetchedNotes = [Note]()
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let noteData = childSnapshot.value as? [String: Any],
                   let id = noteData["id"] as? String,
                   let title = noteData["title"] as? String,
                   let content = noteData["content"] as? String {
                    let note = Note(id: id, title: title, content: content)
                    fetchedNotes.append(note)
                }
            }

            DispatchQueue.main.async {
                self.notes = fetchedNotes
                completed()
            }
        }
    }
    
    func createNote(forUserId userId: String, newNote: Note, completed: @escaping () -> Void) {
        ref.child("users").child(userId).observeSingleEvent(of: .value) { [weak self] snapshot,_  in
            guard let self = self else { return }

            var user: User
            if let userData = snapshot.value as? [String: Any], let jsonData = try? JSONSerialization.data(withJSONObject: userData, options: []) {
                do {
                    let decodedUser = try JSONDecoder().decode(User.self, from: jsonData)
                    user = decodedUser
                } catch {
                    print("Error decoding user: \(error)")
                    user = User(id: userId, username: "New User", notes: [newNote])
                }
            } else {
                user = User(id: userId, username: "New User", notes: [newNote])
            }

            if let noteIndex = user.notes.firstIndex(where: { $0?.id == newNote.id }) {
                user.notes[noteIndex] = newNote
            } else {
                user.notes.append(newNote)
            }
            
            self.ref.child("users").child(userId).setValue(user.toDictionary()) { error, _ in
                if error == nil {
                    completed()
                } else {
                    // Handle the error, if needed
                }
            }
        }
    }
    
    func updateNote(forUserId userId: String, newNote: Note, completion: @escaping (Error?) -> Void) {
        ref.child("users").child(userId).observeSingleEvent(of: .value) { [weak self] snapshot, _ in
            guard let user = snapshot.value as? [String: Any], let jsonData = try? JSONSerialization.data(withJSONObject: user, options: []) else {
                completion(NSError(domain: "UserNotFound", code: 404, userInfo: nil))
                return
            }
            var userExist: User
            do {
                let decodedUser = try JSONDecoder().decode(User.self, from: jsonData)
                userExist = decodedUser
            } catch {
                print("Error decoding user: \(error)")
                userExist = User(id: userId, username: "New User", notes: [newNote])
            }
            
            if let noteIndex = userExist.notes.firstIndex(where: { $0?.id == newNote.id }) {
                userExist.notes[noteIndex] = newNote
            } else {
                userExist.notes.append(newNote)
            }
            self?.ref.child("users").child(userId).setValue(userExist.toDictionary()) { error, _ in
                completion(error)
            }
        }
    }

}
