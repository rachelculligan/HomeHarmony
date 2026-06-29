//
//  Color+Household.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/29/26.
//

import SwiftUI

extension Color {

    init(_ householdColor: String) {

        switch householdColor.lowercased() {

        case "red":
            self = .red

        case "green":
            self = .green

        case "orange":
            self = .orange

        case "purple":
            self = .purple

        case "pink":
            self = .pink

        default:
            self = .blue
        }
    }
}
