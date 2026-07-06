//
//  GroceryListView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 7/2/26.
//


import SwiftUI
import SwiftData

struct GroceryListView: View {

    @Query(sort: \MealPlan.date)
    private var mealPlans: [MealPlan]

    private var groceries: [GroceryItem] {
        GroceryListService.generate(from: mealPlans)
    }

    var body: some View {

        List {

            ForEach(GroceryCategory.allCases, id: \.self) { category in

                let items = groceries.filter {
                    $0.category == category
                }

                if !items.isEmpty {

                    Section(category.rawValue) {

                        ForEach(items) { item in

                            HStack {

                                Image(systemName: "circle")

                                VStack(alignment: .leading) {

                                    Text(item.name)

                                    Text(
                                        "\(item.amount.formatted()) \(item.unit)"
                                    )
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                }

                                Spacer()
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Grocery List")
    }
}