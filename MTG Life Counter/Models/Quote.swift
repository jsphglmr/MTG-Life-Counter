//
//  Quote.swift
//  MTG Life Counter
//
//  Created by Joseph Gilmore on 12/1/25.
//

import Foundation

struct Quote: Identifiable, Codable {
    let id: Int
    let card: String
    let quote: String
    
    // setup coding keys to decode response
    enum CodingKeys: String, CodingKey {
        case id
        case card
        case quote
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.card = try container.decodeIfPresent(String.self, forKey: .card) ?? ""
        self.quote = try container.decodeIfPresent(String.self, forKey: .quote) ?? ""
    }
    
    init(id: Int = 0, card: String, quote: String) {
        self.id = id
        self.card = card
        self.quote = quote
    }
}
