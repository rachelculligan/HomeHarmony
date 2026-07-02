//
//  MealPlannerService.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 7/2/26.
//


import Foundation
import SwiftData

struct MealPlannerService {

    static func createCurrentWeekIfNeeded(
        context: ModelContext,
        existingPlans: [MealPlan]
    ) {

        guard existingPlans.isEmpty else { return }

        let calendar = Calendar.current

        let today = Date()

        guard let week = calendar.dateInterval(
            of: .weekOfYear,
            for: today
        ) else {
            return
        }

        for offset in 0..<7 {

            guard let date = calendar.date(
                byAdding: .day,
                value: offset,
                to: week.start
            ) else {
                continue
            }

            context.insert(
                MealPlan(date: date)
            )
        }

        try? context.save()
    }
    static func assignRecipe(
        _ recipe: Recipe,
        to mealPlan: MealPlan,
        slot: MealSlot,
        context: ModelContext
    ) {

        switch slot {

        case .breakfast:
            mealPlan.breakfast = recipe

        case .lunch:
            mealPlan.lunch = recipe

        case .dinner:
            mealPlan.dinner = recipe
        }

        try? context.save()
    }
    
}
