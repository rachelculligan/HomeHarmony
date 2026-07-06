//
//  MealsHomeView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 7/1/26.
//


import SwiftUI

struct MealsHomeView: View {

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(spacing: 20) {
                    
                    PrimaryCard {

                        VStack(alignment: .leading, spacing: 8) {

                            Text("🍽️ Meals")
                                .font(.largeTitle.bold())

                            Text("Plan your week, save favorite recipes, and generate grocery lists automatically.")
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    MealFeatureCard(
                        title: "Weekly Meal Plan",
                        subtitle: "Plan meals for the week",
                        icon: "calendar",
                        destination: MealPlannerView()
                    )

                    MealFeatureCard(
                        title: "Recipe Library",
                        subtitle: "Browse family favorites",
                        icon: "book.closed.fill",
                        destination: RecipeLibraryView()
                    )

                    MealFeatureCard(
                        title: "Grocery List",
                        subtitle: "Automatically generated",
                        icon: "cart.fill",
                        destination: GroceryListView()
                    )

                    MealFeatureCard(
                        title: "Pantry",
                        subtitle: "Track what you have",
                        icon: "cabinet.fill",
                        destination: GroceryListView()
                    )
                }
                .padding()
            }
            .navigationTitle("Meals")
        }
    }
}
