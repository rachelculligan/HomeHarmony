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
