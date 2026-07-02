//
//  RecipeLibraryView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 7/1/26.
//


import SwiftUI
import SwiftData

struct RecipeLibraryView: View {

    @Query(sort: \Recipe.name)
    private var recipes: [Recipe]

    @State private var searchText = ""
    @State private var showEditor = false

    private var filteredRecipes: [Recipe] {

        guard !searchText.isEmpty else {
            return recipes
        }

        return recipes.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {

        ScrollView {

            LazyVStack(spacing: 16) {

                ForEach(filteredRecipes) { recipe in

                    NavigationLink {

                        RecipeDetailView(recipe: recipe)

                    } label: {

                        RecipeCard(recipe: recipe)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
        .navigationTitle("Recipes")
        .searchable(text: $searchText)

        .toolbar {

            ToolbarItem(placement: .topBarTrailing) {

                Button {

                    showEditor = true

                } label: {

                    Image(systemName: "plus")
                }
            }
        }

        .sheet(isPresented: $showEditor) {

            RecipeEditorView()
        }
    }
}
