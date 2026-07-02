//
//  RecipePickerView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 7/2/26.
//


import SwiftUI
import SwiftData

struct RecipePickerView: View {

    @Environment(\.dismiss) private var dismiss

    @Query(sort: \Recipe.name)
    private var recipes: [Recipe]

    @State private var searchText = ""

    var onSelect: (Recipe) -> Void

    var filteredRecipes: [Recipe] {

        guard !searchText.isEmpty else {
            return recipes
        }

        return recipes.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {

        NavigationStack {

            List {

                ForEach(filteredRecipes) { recipe in

                    Button {

                        onSelect(recipe)
                        dismiss()

                    } label: {

                        RecipeCard(recipe: recipe)
                    }
                    .buttonStyle(.plain)
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Choose Recipe")
        }
    }
}