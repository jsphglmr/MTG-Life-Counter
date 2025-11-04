//
//  Color+Extensions.swift
//  MTG Life Counter
//
//  Created by Joseph Gilmore on 11/3/25.
//
import Foundation
import SwiftUI

public extension Color {
    static func random() -> Color {
        Color(
            red: .random(in: 0.25...0.75),
            green: .random(in: 0.25...0.75),
            blue: .random(in: 0.25...0.75)
        )
    }
}
