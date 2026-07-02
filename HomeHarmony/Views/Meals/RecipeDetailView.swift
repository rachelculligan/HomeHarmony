//
//  RecipeDetailView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 7/1/26.
//

import SwiftUI

struct RecipeDetailView: View {

    let recipe: Recipe

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 20) {

                PrimaryCard {

                    VStack(alignment: .leading, spacing: 12) {

                        HStack {

                            Text(recipe.name)
                                .font(.largeTitle.bold())

                            Spacer()

                            if recipe.favorite {

                                Image(systemName: "heart.fill")
                                    .foregroundStyle(.red)
                            }
                        }

                        Text(recipe.category.rawValue)
                            .foregroundStyle(.secondary)

                        Divider()

                        HStack {

                            Label(
                                "\(recipe.prepTime) min",
                                systemImage: "clock"
                            )

                            Spacer()

                            Label(
                                "\(recipe.servings)",
                                systemImage: "person.2.fill"
                            )
                        }
                        .font(.subheadline)
                    }
                }

                PrimaryCard {

                    VStack(alignment: .leading, spacing: 12) {

                        Text("Ingredients")
                            .font(.headline)

                        if recipe.ingredients.isEmpty {

                            Text("No ingredients")
                                .foregroundStyle(.secondary)

                        } else {

                            ForEach(recipe.ingredients) { ingredient in

                                HStack {

                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(HomeHarmonyTheme.success)

                                    Text(
                                        "\(ingredient.amount.formatted()) \(ingredient.unit) \(ingredient.name)"
                                    )

                                    Spacer()
                                }
                            }
                        }
                    }
                }

                PrimaryCard {

                    VStack(alignment: .leading, spacing: 12) {

                        Text("Instructions")
                            .font(.headline)

                        if recipe.instructions.isEmpty {

                            Text("No instructions yet.")
                                .foregroundStyle(.secondary)

                        } else {

                            Text(recipe.instructions)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
