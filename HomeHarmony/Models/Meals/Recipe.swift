//
//  Recipe.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 7/1/26.
//


import Foundation
import SwiftData

@Model
class Recipe {

    var name: String
    var category: RecipeCategory
    var prepTime: Int
    var cookTime: Int
    var servings: Int
    var favorite: Bool
    var instructions: String

    @Relationship(deleteRule: .cascade)
    var ingredients: [Ingredient]

    init(
        name: String,
        category: RecipeCategory = .dinner,
        prepTime: Int = 15,
        cookTime: Int = 30,
        servings: Int = 4,
        favorite: Bool = false,
        instructions: String = "",
        ingredients: [Ingredient] = []
    ) {
        self.name = name
        self.category = category
        self.prepTime = prepTime
        self.cookTime = cookTime
        self.servings = servings
        self.favorite = favorite
        self.instructions = instructions
        self.ingredients = ingredients
    }
}

enum RecipeCategory: String, Codable, CaseIterable {

    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case dessert = "Dessert"
    case snack = "Snack"
    case baking = "Baking"
}
