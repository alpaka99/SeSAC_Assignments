//
//  Color+.swift
//  SwiftUIRecap2
//
//  Created by user on 9/4/24.
//

import SwiftUI

extension Color {
    static func random() -> Color {
        return Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
}
