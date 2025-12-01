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
    var quote: Quote = Quote(id: 0, card: "", quote: "")
    
    func getQuote() async {
        guard let url = URL(string: "http://127.0.0.1:5002/quote") else {
            print("url error")
            return
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            quote = try JSONDecoder().decode(Quote.self, from: data)
            print(quote.card)
            print(quote.quote)
        } catch {
            print("Error getting quote: \(error)")
        }
    }
}
