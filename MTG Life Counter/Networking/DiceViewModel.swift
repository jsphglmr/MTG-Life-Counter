//
//  DiceViewModel.swift
//  MTG Life Counter
//
//  Created by Joseph Gilmore on 11/26/25.
//

import Foundation
import Observation

@Observable
class DiceViewModel {
    var diceRoll: DiceRoll = DiceRoll(id: 0, minVal: 0, maxVal: 0, result: 0)
    
    func rollDice(min: Int, max: Int) async {
        guard let url = URL(string: "http://127.0.0.1:5001/random-number?min_val=\(min)&max_val=\(max)") else {
            print("url error")
            return
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            diceRoll = try JSONDecoder().decode(DiceRoll.self, from: data)
        } catch {
            print("Error flipping coin: \(error)")
        }
    }
}


