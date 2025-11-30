//
//  DiceRoll.swift
//  MTG Life Counter
//
//  Created by Joseph Gilmore on 11/26/25.
//

import Foundation

struct DiceRoll: Identifiable, Codable {
    let id: Int
    let minVal: Int
    let maxVal: Int
    let result: Int
    
    enum CodingKeys: String, CodingKey {
        case minVal = "min_val"
        case maxVal = "max_val"
        case result
    }
    
    init(id: Int = 0, minVal: Int, maxVal: Int, result: Int) {
        self.id = id
        self.minVal = minVal
        self.maxVal = maxVal
        self.result = result
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = 0
        self.minVal = try container.decode(Int.self, forKey: .minVal)
        self.maxVal = try container.decode(Int.self, forKey: .maxVal)
        self.result = try container.decode(Int.self, forKey: .result)
    }
}
