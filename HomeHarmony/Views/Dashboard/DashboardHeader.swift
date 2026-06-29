//
//  DashboardHeader.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/26/26.
//

import SwiftUI

struct DashboardHeader: View {

    let householdName: String
    let streak: Int
    let overdue: Int
    let dueToday: Int
    let focus: Int

    var body: some View {

        Section {

            VStack(spacing: 12) {

                Text("🏠 \(householdName)")
                    .font(.headline)

                Text("🔥 \(streak) Day Streak")
                    .font(.title)
                    .bold()

                HStack {

                    stat(
                        title: "Overdue",
                        value: overdue
                    )

                    Spacer()

                    stat(
                        title: "Due Today",
                        value: dueToday
                    )

                    Spacer()

                    stat(
                        title: "Focus",
                        value: focus
                    )
                }

                Text("Keep it up! 💪")
                    .foregroundStyle(.secondary)

            }
            .frame(maxWidth: .infinity)
            .padding(.vertical)
        }
    }

    @ViewBuilder
    func stat(
        title: String,
        value: Int
    ) -> some View {

        VStack {

            Text("\(value)")
                .font(.title2)
                .bold()

            Text(title)
                .font(.caption)
        }
    }
}
