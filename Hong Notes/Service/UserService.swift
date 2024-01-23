//
//  UserService.swift
//  Hong Notes
//
//  Created by dtthong on 20/01/2024.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class UserService: ObservableObject {
    private var ref = Database.database().reference()
    @Published
    var users = [User]()
    @Published
    var user: User?
    
    func getUsers(completed: @escaping () -> Void) {
        ref.child("users").observe(.value) { [weak self] snapshot in
            guard let self = self, let child = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            self.users = child.compactMap { snapshot in
                do {
                    let user = try snapshot.data(as: User.self)
                    print(snapshot)
                    return user
                } catch {
                    print("Failed to decode User: \(snapshot), Error: \(error)")
                    return nil
                }
            }
            completed()
        }
    }
    func getUser(completed: @escaping () -> Void){
        ref.child("0").observe(.value) { snapshot in
            do {
                self.user = try snapshot.data(as: User.self)
                completed()
            } catch {
                print("Can't convert User")
            }
            
        }
    }
    
    func pushUser(value: User, completion: @escaping () -> Void) {
        ref.child("users").child(value.id).setValue(value.toDictionary()) {
            error, _ in
            if let error = error {
                print("Error occurred: \(error.localizedDescription)")
            } else {
                completion()
            }
        }
    }
}
