//
//  GroceryItem.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 7/2/26.
//


import Foundation

struct GroceryItem: Identifiable, Hashable {

    let id = UUID()

    let name: String
    let amount: Double
    let unit: String
    let category: GroceryCategory

    var isChecked = false
}
