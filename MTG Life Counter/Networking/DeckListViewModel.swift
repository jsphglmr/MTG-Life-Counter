//
//  DeckListViewModel.swift
//  MTG Life Counter
//
//  Created by Joseph Gilmore on 11/29/25.
//

import Foundation
import Observation

@Observable
class DeckListViewModel {
    var deckList: [Deck] = []
    
    @MainActor
    func getDecks() async {
        guard let url = URL(string: "http://127.0.0.1:5004/decks") else {
            print("url error")
            return
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let deckDictionary = try JSONDecoder().decode([String: Int].self, from: data)
            
            // make dictionary and sort by bracket level
            self.deckList = deckDictionary.map { key, value in
                Deck(id: UUID(), commander: key, bracket: value)
            }.sorted { $0.bracket < $1.bracket }
            
        } catch {
            print("Error connecting to internet: \(error)")
        }
    }
}

struct Deck: Identifiable {
    let id: UUID
    let commander: String
    let bracket: Int
}
