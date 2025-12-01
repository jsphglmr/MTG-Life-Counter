//
//  Deck.swift
//  MTG Life Counter
//
//  Created by Joseph Gilmore on 12/1/25.
//

import Foundation

struct Deck: Identifiable {
    let id: UUID
    let commander: String
    let bracket: Int
}
