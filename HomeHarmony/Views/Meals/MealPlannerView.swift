//
//  MealPlannerView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 7/1/26.
//

import SwiftUI
import SwiftData

struct MealPlannerView: View {

    @Environment(\.modelContext) private var context

    @Query(sort: \MealPlan.date)
    private var mealPlans: [MealPlan]

    @State private var showCopyConfirmation = false
    @State private var selectedWeekStart = Calendar.current.dateInterval(
        of: .weekOfYear,
        for: Date()
    )?.start ?? Date()
    @State private var selectedMealPlan: MealPlan?
    @State private var selectedSlot: MealSlot?
    @State private var showRecipePicker = false

    var body: some View {

        NavigationStack {
            
            VStack(spacing: 16) {
                
                WeekHeader(
                    weekStart: $selectedWeekStart
                )
                Text("Meal Plans: \(mealPlans.count)")
                    .foregroundStyle(.red)
                
                Text("Current Week: \(currentWeekPlans.count)")
                    .foregroundStyle(.blue)
                ScrollView {
                    
                    LazyVStack(spacing: 16) {
                        
                        ForEach(currentWeekPlans) { day in
                            
                            MealDayCard(
                                date: day.date,
                                breakfast: day.breakfast?.name,
                                lunch: day.lunch?.name,
                                dinner: day.dinner?.name,
                                
                                breakfastAction: {
                                    selectedMealPlan = day
                                    selectedSlot = .breakfast
                                    showRecipePicker = true
                                },
                                
                                lunchAction: {
                                    selectedMealPlan = day
                                    selectedSlot = .lunch
                                    showRecipePicker = true
                                },
                                
                                dinnerAction: {
                                    selectedMealPlan = day
                                    selectedSlot = .dinner
                                    showRecipePicker = true
                                }
                            )
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Meal Planner")
            
            .onAppear {
                
                MealPlannerService.createCurrentWeekIfNeeded(
                    context: context,
                    existingPlans: mealPlans
                )
            }
            
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button {
                        
                        showCopyConfirmation = true
                        
                    } label: {
                        
                        Label(
                            "Copy Last Week",
                            systemImage: "doc.on.doc"
                        )
                    }
                }
            }
            
            .confirmationDialog(
                "Copy last week's meals?",
                isPresented: $showCopyConfirmation,
                titleVisibility: .visible
            ) {
                
                Button("Copy Meals") {
                    
                    copyLastWeek()
                }
                
                Button("Cancel", role: .cancel) { }
                
            } message: {
                
                Text("This will replace this week's planned meals with last week's meals.")
            }
            .sheet(isPresented: $showRecipePicker) {

                RecipePickerView { recipe in

                    guard
                        let mealPlan = selectedMealPlan,
                        let slot = selectedSlot
                    else {
                        return
                    }

                    print("Selected recipe: \(recipe.name)")
                    print("Meal Plan: \(mealPlan.date)")
                    print("Slot: \(slot)")

                    MealPlannerService.assignRecipe(
                        recipe,
                        to: mealPlan,
                        slot: slot,
                        context: context
                    )

                    print("Assignment complete")
                }
            }
 
        }
    }

    private var currentWeekPlans: [MealPlan] {

        let calendar = Calendar.current

        guard let week = calendar.dateInterval(
            of: .weekOfYear,
            for: selectedWeekStart
        ) else {
            return []
        }

        return mealPlans.filter {
            $0.date >= week.start && $0.date < week.end
        }
        .sorted { $0.date < $1.date }
    }
    private func copyLastWeek() {

        let calendar = Calendar.current

        for currentDay in mealPlans {

            guard let lastWeekDate = calendar.date(
                byAdding: .day,
                value: -7,
                to: currentDay.date
            ) else {
                continue
            }

            guard let previousDay = mealPlans.first(where: {
                calendar.isDate($0.date, inSameDayAs: lastWeekDate)
            }) else {
                continue
            }

            currentDay.breakfast = previousDay.breakfast
            currentDay.lunch = previousDay.lunch
            currentDay.dinner = previousDay.dinner
        }

        try? context.save()
    }
}

#Preview {
    MealPlannerView()
}
