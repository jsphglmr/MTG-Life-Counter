//
//  InternetStatus.swift
//  MTG Life Counter
//
//  Created by Joseph Gilmore on 12/1/25.
//

import Foundation

struct InternetStatus: Identifiable, Codable {
    let id: Int
    let url: String
    let working: Bool
    
    
    // setup coding keys to decode response
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case working
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        self.working = try container.decodeIfPresent(Bool.self, forKey: .working) ?? false
    }
    
    init(id: Int = 0, url: String, working: Bool) {
        self.id = id
        self.url = url
        self.working = working
    }
}
