//
//  QuickActionsCard.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/29/26.
//

import SwiftUI

struct QuickActionsCard: View {

    let onTemplates: () -> Void

    var body: some View {

        PrimaryCard {

            SectionHeader(
                title: "Quick Actions",
                icon: "bolt.fill"
            )

            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 18
            ) {

                ActionButton(
                    title: "Templates",
                    icon: "square.grid.2x2.fill",
                    color: .orange
                ) {
                    onTemplates()
                }

                NavigationLink {

                    AddTaskView()

                } label: {

                    ActionButtonLabel(
                        title: "Add Task",
                        icon: "plus.circle.fill",
                        color: .green
                    )
                }

                NavigationLink {

                    RewardsView()

                } label: {

                    ActionButtonLabel(
                        title: "Rewards",
                        icon: "gift.fill",
                        color: .purple
                    )
                }

                NavigationLink {

                    HouseholdView()

                } label: {

                    ActionButtonLabel(
                        title: "Family",
                        icon: "person.3.fill",
                        color: .blue
                    )
                }
            }
        }
    }
}
