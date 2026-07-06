//
//  GroceryListService.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 7/2/26.
//


import Foundation

struct GroceryListService {

    static func generate(from mealPlans: [MealPlan]) -> [GroceryItem] {

        var totals: [String: GroceryItem] = [:]

        for plan in mealPlans {

            let recipes = [
                plan.breakfast,
                plan.lunch,
                plan.dinner
            ]

            for recipe in recipes.compactMap({ $0 }) {

                for ingredient in recipe.ingredients {

                    let key = "\(ingredient.name.lowercased())-\(ingredient.unit.lowercased())"

                    if let existing = totals[key] {

                        totals[key] = GroceryItem(
                            name: existing.name,
                            amount: existing.amount + ingredient.amount,
                            unit: existing.unit,
                            category: existing.category
                        )

                    } else {

                        totals[key] = GroceryItem(
                            name: ingredient.name,
                            amount: ingredient.amount,
                            unit: ingredient.unit,
                            category: ingredient.groceryCategory
                        )
                    }
                }
            }
        }

        return totals.values.sorted {

            if $0.category == $1.category {

                return $0.name < $1.name
            }

            return $0.category.rawValue < $1.category.rawValue
        }
    }
}