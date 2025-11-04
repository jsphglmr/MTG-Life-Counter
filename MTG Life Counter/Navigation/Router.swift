//
//  Router.swift
//  MTG Life Counter
//
//  Created by Joseph Gilmore on 11/3/25.
//

import Foundation
import SwiftUI
import Observation

@Observable
class Router {
    var path = NavigationPath()
    
    func navigateToSetupView() {
        path.append(Route.setup)
    }
    
    func navigateToGameView(playerCount: Int) {
        path.append(Route.game(playerCount: playerCount))
    }
    
    func navigateToMenu() {
        path.append(Route.menu)
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}

enum Route: Hashable {
    case setup
    case game(playerCount: Int)
    case menu
}
