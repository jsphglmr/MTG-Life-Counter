//
//  QuoteViewModel.swift
//  MTG Life Counter
//
//  Created by Joseph Gilmore on 11/30/25.
//

import Foundation
import Observation

@Observable
class QuoteViewModel {
    var quote: Quote = Quote(id: UUID(), card: "", quote: "")
    
    @MainActor
    func getQuote() async {
        guard let url = URL(string: "http://127.0.0.1:5002/quote") else {
            print("url error")
            return
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            quote = try JSONDecoder().decode(Quote.self, from: data)
        } catch {
            print("Error connecting to internet: \(error)")
        }
    }
}

struct Quote: Identifiable, Codable {
    let id: UUID
    let card: String
    let quote: String
}
