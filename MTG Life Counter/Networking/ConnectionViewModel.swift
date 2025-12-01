//
//  ConnectionViewModel.swift
//  MTG Life Counter
//
//  Created by Joseph Gilmore on 11/29/25.
//

import Foundation
import Observation

@Observable
class ConnectionViewModel {
    var isConnected: Bool = false
    
    @MainActor
    func checkInternet() async {
        guard let url = URL(string: "http://127.0.0.1:5003/check_internet") else {
            print("issue with URL")
            isConnected = false
            return
        }
        
        let request = URLRequest(url: url)
//        request.timeoutInterval = 3 // Set a short timeout for connection checks
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let status = try JSONDecoder().decode(InternetStatus.self, from: data)
                isConnected = status.working
            } else {
                isConnected = false
            }
        } catch {
            print("Error connecting to internet: \(error)")
            isConnected = false
        }
    }
}

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
