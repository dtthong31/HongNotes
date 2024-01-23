//
//  HomeView.swift
//  Hong Notes
//
//  Created by dtthong on 19/01/2024.
//

import SwiftUI

struct ListNoteView: View {
    var userId: String
    @Environment(\.presentationMode) private var presentationMode

    @ObservedObject private var viewModel =  ListNoteModel(userId: "")

    init(userId: String) {
        self.userId = userId
    }
    
    var body: some View {
        VStack(alignment: .trailing) {
            VStack{
                if viewModel.notes.count > 0 {
                    List(viewModel.notes, id: \.self) { note in
                        NavigationLink{
                            NoteView(userId: userId, note: note)
                            } label: {
                                Text(note.title)
                            }
                        }
                        .refreshable {
                            viewModel.getNotes(userId: userId)
                        }
                } else {
                    Text("Please create new note")
                }
            }
            .navigationBarTitle("Notes", displayMode: .inline).frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear{
            viewModel.getNotes(userId: userId)
        }
        .navigationBarItems( leading:
                                Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                                }) {
                                    HStack {
                                        Image(systemName: "chevron.left")
                                    }.navigationBarBackButtonHidden()
        }, trailing:
            NavigationLink(
                destination: NoteView(userId: userId, note: nil),
                label: {
                    Image(systemName: "plus").padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 20))}
            )
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let userId = "1"
        return ListNoteView(userId: userId)
       
    }
}
