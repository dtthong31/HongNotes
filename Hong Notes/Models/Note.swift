//
//  Note.swift
//  Hong Notes
//
//  Created by dtthong on 19/01/2024.
//

import Foundation

struct Note: Encodable, Decodable, Hashable {
    var id: String
    var title: String
    var content: String

    init(id: String, title: String, content: String) {
        self.id = id
        self.title = title
        self.content = content
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Try to decode the ID as an Int, and if successful, convert it to String
        if let idInt = try? container.decode(Int.self, forKey: .id) {
            id = String(idInt)
        } else {
            id = try container.decode(String.self, forKey: .id)
        }

        title = try container.decode(String.self, forKey: .title)
        content = try container.decode(String.self, forKey: .content)
    }

    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "title": title,
            "content": content
        ]
    }

    // Define coding keys if your property names differ from your JSON keys
    enum CodingKeys: String, CodingKey {
        case id, title, content
    }
}
