//
//  Achievement.swift
//  CleaningADHD
//
//  Created by Rachel Culligan on 6/26/26.
//

import Foundation
import SwiftData

@Model
class Achievement {

    var title: String
    var details: String
    var icon: String
    var points: Int
    var unlocked: Bool

    init(
        title: String,
        details: String,
        icon: String,
        points: Int,
        unlocked: Bool = false
    ) {
        self.title = title
        self.details = details
        self.icon = icon
        self.points = points
        self.unlocked = unlocked
    }
}
