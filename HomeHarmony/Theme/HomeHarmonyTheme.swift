//
//  HomeHarmonyTheme.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/30/26.
//

import SwiftUI

enum HomeHarmonyTheme {

    // MARK: - Brand Colors


    static let primary = Color(
        red: 0.23,
        green: 0.48,
        blue: 0.65
    )

    // MARK: - Status Colors

    static let secondary = Color(
           red: 0.91,
           green: 0.73,
           blue: 0.35
       )
    
    static let success = Color(
           red: 0.32,
           green: 0.67,
           blue: 0.42
       )

    static let warning = Color.orange
    static let danger = Color.red
 
    // MARK: - Backgrounds

    static let cardBackground = Color(.secondarySystemBackground)
    static let appBackground = Color(.systemGroupedBackground)

    // MARK: - Text

    static let primaryText = Color.primary
    static let secondaryText = Color.secondary

    // MARK: - Accent

    static let accent = Color.yellow
}
