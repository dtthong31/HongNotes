//
//  LoginView.swift
//  Hong Notes
//
//  Created by dtthong on 17/01/2024.
//

import SwiftUI

struct RegisterView: View {
    @Binding var isRegister: Bool
    @Environment(\.presentationMode) private var presentationMode
    @State private var username: String = ""
    
    private let userService = UserService()
    
    var body: some View {
        VStack {
            Text("SET USER NAME").fontWeight(.bold)
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: {
                authenticateUser(username: username)
            }) {
                Text("Register")
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .navigationTitle("Set user name")
        
    }
    
    func authenticateUser(username: String) {
        let user = User(id: UUID().uuidString, username: username, notes: [])
        userService.pushUser(value: user){
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

