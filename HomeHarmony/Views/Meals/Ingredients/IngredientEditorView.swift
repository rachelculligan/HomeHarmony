//
//  IngredientEditorView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 7/1/26.
//


import SwiftUI

struct IngredientEditorView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var amount = 1.0
    @State private var unit = ""
    @State private var category: GroceryCategory = .other

    var onSave: (Ingredient) -> Void

    var body: some View {

        NavigationStack {

            Form {

                Section("Ingredient") {

                    TextField(
                        "Name",
                        text: $name
                    )

                    HStack {

                        Text("Amount")

                        Spacer()

                        TextField(
                            "1",
                            value: $amount,
                            format: .number
                        )
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                    }

                    TextField(
                        "Unit",
                        text: $unit
                    )

                    Picker(
                        "Category",
                        selection: $category
                    ) {

                        ForEach(
                            GroceryCategory.allCases,
                            id: \.self
                        ) { category in

                            Text(category.rawValue)
                                .tag(category)
                        }
                    }
                }
            }
            .navigationTitle("Ingredient")
            .toolbar {

                ToolbarItem(
                    placement: .confirmationAction
                ) {

                    Button("Save") {

                        let ingredient = Ingredient(
                            name: name,
                            amount: amount,
                            unit: unit,
                            groceryCategory: category
                        )

                        onSave(ingredient)
                        dismiss()
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
        }
    }
}