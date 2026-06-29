//
//  RewardRedemption.swift
//  CleaningADHD
//
//  Created by Rachel Culligan on 6/25/26.
//

import Foundation
import SwiftData

@Model
class RewardRedemption {

    var rewardTitle: String
    var memberName: String
    var pointsSpent: Int
    var requestDate: Date
    var approved: Bool

    init(
        rewardTitle: String,
        memberName: String,
        pointsSpent: Int,
        requestDate: Date = .now,
        approved: Bool = false
    ) {
        self.rewardTitle = rewardTitle
        self.memberName = memberName
        self.pointsSpent = pointsSpent
        self.requestDate = requestDate
        self.approved = approved
    }
}
