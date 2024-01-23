//
//  ListUserView.swift
//  Hong Notes
//
//  Created by dtthong on 20/01/2024.
//

import SwiftUI

struct ListUserView: View {
    @StateObject private var viewModel = ListUserModel()
    @State private var isRegister = false
    
    var body: some View {
        VStack(alignment: .trailing) {
            List(viewModel.users, id: \.self) { user in
                NavigationLink {
                    ListNoteView(userId: user.id)
                } label: {
                    Text(user.username)
                }
            }
            .refreshable {
                viewModel.getUsers()
            }
        }
        .navigationBarItems(trailing: NavigationLink(destination: RegisterView(isRegister: $isRegister)) {
            Image(systemName: "plus").padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 20))
        })
        .navigationBarTitle("Users", displayMode: .inline)
    }
}

struct ListUserView_Previews: PreviewProvider {
    static var previews: some View {
        ListUserView()
    }
}
