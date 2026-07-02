//
//  HouseholdMember.swift
//  CleaningADHD
//
//  Created by Rachel Culligan on 6/17/26.
//

import Foundation
import SwiftData

@Model
class HouseholdMember {

    var name: String
    var avatar: String = "person.circle.fill"
    var color: String = "blue"
    var points: Int = 0
    var lifetimePoints: Int = 0
    var tasksCompleted: Int = 0
    var currentStreak: Int = 0
    var longestStreak: Int = 0
    var level: Int = 1
    var experience: Int = 0

    var experienceNeeded: Int {
        100 + ((level - 1) * 50)
    }

    var experienceProgress: Double {
        guard experienceNeeded > 0 else { return 0 }
        return Double(experience) / Double(experienceNeeded)
    }

    init(
        name: String,
        avatar: String = "person.circle.fill",
        color: String = "blue",
        points: Int = 0
    ) {
        self.name = name
        self.avatar = avatar
        self.color = color
        self.points = points
    }
}
