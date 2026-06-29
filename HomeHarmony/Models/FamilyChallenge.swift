//
//  FamilyChallenge.swift
//  CleaningADHD
//
//  Created by Rachel Culligan on 6/26/26.
//

import Foundation
import SwiftData

@Model
class FamilyChallenge {

    var title: String
    var goal: Int
    var reward: String
    var startDate: Date
    var endDate: Date

    init(
        title: String,
        goal: Int,
        reward: String,
        startDate: Date = .now,
        endDate: Date = Calendar.current.date(byAdding: .day, value: 7, to: .now)!
    ) {

        self.title = title
        self.goal = goal
        self.reward = reward
        self.startDate = startDate
        self.endDate = endDate
    }
}
