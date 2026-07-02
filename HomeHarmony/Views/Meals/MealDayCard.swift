//
//  MealDayCard.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 7/1/26.
//


import SwiftUI

struct MealDayCard: View {

    let date: Date
    let breakfast: String?
    let lunch: String?
    let dinner: String?

    var breakfastAction: (() -> Void)?
    var lunchAction: (() -> Void)?
    var dinnerAction: (() -> Void)?

    var body: some View {

        PrimaryCard {

            VStack(alignment: .leading, spacing: 16) {

                Text(
                    date.formatted(
                        .dateTime
                            .weekday(.wide)
                    )
                )
                .font(.title3.bold())

                MealRow(
                    icon: "sunrise.fill",
                    title: "Breakfast",
                    meal: breakfast,
                    action: breakfastAction
                )

                MealRow(
                    icon: "sun.max.fill",
                    title: "Lunch",
                    meal: lunch,
                    action: lunchAction
                )

                MealRow(
                    icon: "moon.stars.fill",
                    title: "Dinner",
                    meal: dinner,
                    action: dinnerAction
                )
            }
        }
    }
}
