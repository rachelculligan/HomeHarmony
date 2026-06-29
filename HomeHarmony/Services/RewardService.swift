//
//  RewardService.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/25/26.
//

import Foundation
import SwiftData

struct RewardService {

    static func awardPoints(
        to memberName: String,
        amount: Int,
        members: [HouseholdMember],
        context: ModelContext
    ) {

        guard let member = members.first(where: {
            $0.name == memberName
        }) else {
            return
        }

        member.points += amount

        try? context.save()
    }

    static func redeem(
        reward: Reward,
        member: HouseholdMember,
        context: ModelContext
    ) -> Bool {

        guard member.points >= reward.points else {
            return false
        }

        member.points -= reward.points

        let redemption = RewardRedemption(
            rewardTitle: reward.title,
            memberName: member.name,
            pointsSpent: reward.points
        )

        context.insert(redemption)

        try? context.save()

        return true
    }
}
