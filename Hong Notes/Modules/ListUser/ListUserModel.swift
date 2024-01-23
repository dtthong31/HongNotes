//
//  ListUserModel.swift
//  Hong Notes
//
//  Created by dtthong on 20/01/2024.
//

import Foundation

class ListUserModel: ObservableObject {
    var userService = UserService()
    
    @Published
    var user: User?
    @Published
    var users = [User]()
    
    init(){
        getUsers()
    }
    
    func getUsers() {
        userService.getUsers() {
            self.users = self.userService.users
        }
    }
    
    func getNote() {
        userService.getUser {
            self.user = self.userService.user
        }
    }
}
