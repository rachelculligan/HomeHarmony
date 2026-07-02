//
//  RecipeEditorView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 7/1/26.
//


import SwiftUI
import SwiftData

struct RecipeEditorView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @State private var name = ""
    @State private var category: RecipeCategory = .dinner
    @State private var prepTime = 15
    @State private var cookTime = 30
    @State private var servings = 4
    @State private var instructions = ""
    @State private var favorite = false
    @State private var ingredients: [Ingredient] = []
    @State private var showIngredientEditor = false

    var body: some View {

        NavigationStack {

            Form {

                Section("Recipe") {

                    TextField(
                        "Recipe Name",
                        text: $name
                    )

                    Picker(
                        "Category",
                        selection: $category
                    ) {

                        ForEach(
                            RecipeCategory.allCases,
                            id: \.self
                        ) { category in

                            Text(category.rawValue)
                                .tag(category)
                        }
                    }

                    Toggle(
                        "Family Favorite",
                        isOn: $favorite
                    )
                }

                Section("Details") {

                    Stepper(
                        "Prep Time: \(prepTime) min",
                        value: $prepTime,
                        in: 0...240
                    )

                    Stepper(
                        "Cook Time: \(cookTime) min",
                        value: $cookTime,
                        in: 0...480
                    )

                    Stepper(
                        "Servings: \(servings)",
                        value: $servings,
                        in: 1...20
                    )
                }
                Section("Ingredients") {

                    if ingredients.isEmpty {

                        Text("No ingredients added yet")
                            .foregroundStyle(.secondary)

                    } else {

                        ForEach(ingredients) { ingredient in

                            HStack {

                                Text("\(ingredient.amount.formatted())")

                                if !ingredient.unit.isEmpty {
                                    Text(ingredient.unit)
                                }

                                Text(ingredient.name)

                                Spacer()
                            }
                        }
                        .onDelete { indexSet in
                            ingredients.remove(atOffsets: indexSet)
                        }
                    }

                    Button {

                        showIngredientEditor = true

                    } label: {

                        Label(
                            "Add Ingredient",
                            systemImage: "plus.circle.fill"
                        )
                    }
                }
                Section("Instructions") {

                    TextEditor(
                        text: $instructions
                    )
                    .frame(height: 150)
                }
            }
            .navigationTitle("New Recipe")
            .toolbar {

                ToolbarItem(
                    placement: .confirmationAction
                ) {

                    Button("Save") {

                        saveRecipe()
                    }
                    .disabled(name.isEmpty)
                }

                ToolbarItem(
                    placement: .cancellationAction
                ) {

                    Button("Cancel") {

                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showIngredientEditor) {

                IngredientEditorView { ingredient in

                    ingredients.append(ingredient)
                }
            }
        }
    }

    private func saveRecipe() {

        let recipe = Recipe(
            name: name,
            category: category,
            prepTime: prepTime,
            cookTime: cookTime,
            servings: servings,
            favorite: favorite,
            instructions: instructions,
            ingredients: ingredients
        )

        context.insert(recipe)

        try? context.save()

        dismiss()
    }
}
