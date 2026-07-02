//
//  MealPlan.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 7/1/26.
//


import Foundation
import SwiftData

@Model
class MealPlan {

    var date: Date

    @Relationship
    var breakfast: Recipe?

    @Relationship
    var lunch: Recipe?

    @Relationship
    var dinner: Recipe?

    init(
        date: Date,
        breakfast: Recipe? = nil,
        lunch: Recipe? = nil,
        dinner: Recipe? = nil
    ) {
        self.date = date
        self.breakfast = breakfast
        self.lunch = lunch
        self.dinner = dinner
    }
}
