//
//  User.swift
//  Hong Notes
//
//  Created by dtthong on 19/01/2024.
//

import Foundation

class User: Encodable, Decodable, Hashable {
    var id: String
    var username: String
    var notes: [Note?] = []
    
    init(id: String, username: String, notes: [Note?]) {
        self.id = id
        self.username = username
        self.notes = notes
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let idInt = try? container.decode(Int.self, forKey: .id) {
            id = String(idInt)
        } else {
            id = try container.decode(String.self, forKey: .id)
        }
        
        username = try container.decode(String.self, forKey: .username)

        // Handle the notes field - it's optional now
        notes = (try? container.decode([Note?].self, forKey: .notes)) ?? []
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "username": username,
            "notes": notes.compactMap { $0?.toDictionary() }
        ]
    }
}
