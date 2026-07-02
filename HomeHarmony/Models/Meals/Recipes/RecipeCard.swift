//
//  RecipeCard.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 7/1/26.
//


import SwiftUI

struct RecipeCard: View {

    let recipe: Recipe

    var body: some View {

        PrimaryCard {

            HStack(spacing: 18) {

                ZStack {

                    Circle()
                        .fill(HomeHarmonyTheme.primary.opacity(0.15))
                        .frame(width: 52, height: 52)

                    Text(icon)
                        .font(.title2)
                }

                VStack(alignment: .leading, spacing: 6) {

                    HStack {

                        Text(recipe.name)
                            .font(.headline)

                        if recipe.favorite {

                            Image(systemName: "heart.fill")
                                .foregroundStyle(.red)
                        }
                    }

                    Text(recipe.category.rawValue)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    HStack {

                        Label(
                            "\(recipe.prepTime + recipe.cookTime) min",
                            systemImage: "clock"
                        )

                        Label(
                            "\(recipe.servings)",
                            systemImage: "person.2.fill"
                        )
                    }
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundStyle(.tertiary)
            }
        }
    }

    private var icon: String {

        switch recipe.category {

        case .breakfast:
            return "🍳"

        case .lunch:
            return "🥪"

        case .dinner:
            return "🍝"

        case .dessert:
            return "🍰"

        case .snack:
            return "🥨"

        case .baking:
            return "🍞"
        }
    }
}
