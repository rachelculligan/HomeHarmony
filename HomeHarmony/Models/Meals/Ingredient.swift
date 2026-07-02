//
//  Ingredient.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 7/1/26.
//


import Foundation
import SwiftData

@Model
class Ingredient {

    var name: String
    var amount: Double
    var unit: String
    var groceryCategory: GroceryCategory

    init(
        name: String,
        amount: Double = 1,
        unit: String = "",
        groceryCategory: GroceryCategory = .other
    ) {
        self.name = name
        self.amount = amount
        self.unit = unit
        self.groceryCategory = groceryCategory
    }
}

enum GroceryCategory: String, Codable, CaseIterable {

    case produce = "Produce"
    case dairy = "Dairy"
    case meat = "Meat"
    case frozen = "Frozen"
    case pantry = "Pantry"
    case bakery = "Bakery"
    case beverages = "Beverages"
    case snacks = "Snacks"
    case household = "Household"
    case other = "Other"
}
