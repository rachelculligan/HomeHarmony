//
//  Reward.swift
//  CleaningADHD
//
//  Created by Rachel Culligan on 6/25/26.
//

import Foundation
import SwiftData

@Model
class Reward {

    var title: String
    var points: Int
    var icon: String
    var claimed: Bool

    init(
        title: String,
        points: Int,
        icon: String,
        claimed: Bool = false
    ) {
        self.title = title
        self.points = points
        self.icon = icon
        self.claimed = claimed
    }
}
