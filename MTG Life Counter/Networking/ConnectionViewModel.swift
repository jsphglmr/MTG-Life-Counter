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
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 2
        
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

