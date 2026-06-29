//
//  Household.swift
//  CleaningADHD
//
//  Created by Rachel Culligan on 6/16/26.
//

import Foundation
import SwiftData

@Model
class Household {
    
    var name: String
    var inviteCode: String
    var weeklyGoal: Int
    
    init(
        name: String,
        inviteCode: String,
        weeklyGoal: Int = 10
    ) {
        self.name = name
        self.inviteCode = inviteCode
        self.weeklyGoal = weeklyGoal
    }
}

