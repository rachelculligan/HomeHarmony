//
//  AchievementService.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/26/26.
//

import Foundation
import SwiftData

struct AchievementService {

    static func loadDefaults(
        context: ModelContext
    ) {

        let achievements = [

            Achievement(
                title: "First Task",
                details: "Complete your first chore.",
                icon: "star.fill",
                points: 25
            ),

            Achievement(
                title: "7 Day Streak",
                details: "Clean for seven consecutive days.",
                icon: "flame.fill",
                points: 100
            ),

            Achievement(
                title: "Quick Win Master",
                details: "Complete 100 Quick Wins.",
                icon: "bolt.fill",
                points: 150
            ),

            Achievement(
                title: "Kitchen Hero",
                details: "Complete 100 kitchen tasks.",
                icon: "fork.knife",
                points: 100
            )
        ]

        achievements.forEach {
            context.insert($0)
        }

        try? context.save()
    }
}
