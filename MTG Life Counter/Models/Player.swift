//
//  Item.swift
//  MTG Life Counter
//
//  Created by Joseph Gilmore on 11/2/25.
//

import Foundation
import SwiftData

@Model
final class Player {
    var name: String
    var health: Int = 40
    var commanderDamage: Int = 0
    var color: String
    var isDead: Bool = false
    var deathQuote: Quote?
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    
    static func testPlayerData() -> Player {
        return Player(name: "TEST NAME", color: "RED")
    }
}
