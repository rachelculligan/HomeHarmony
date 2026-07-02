//
//  MemberProfileView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/30/26.
//

import SwiftUI

struct ProfileView: View {

    let member: HouseholdMember

    var body: some View {

        ScrollView {

            VStack(spacing: 24) {

                AvatarView(
                    member: member,
                    size: 100
                )

                VStack(spacing: 6) {

                    Text(member.name)
                        .font(.largeTitle.bold())

                    Text("Level \(member.level)")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }

                XPBadge(
                    level: member.level,
                    experience: member.experience,
                    experienceNeeded: member.experienceNeeded
                )

                statsGrid
            }
            .padding()
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var statsGrid: some View {

        LazyVGrid(
            columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ],
            spacing: 16
        ) {

            StatTile(
                title: "Points",
                value: "\(member.points)",
                icon: "star.fill",
                color: .yellow
            )

            StatTile(
                title: "Lifetime",
                value: "\(member.lifetimePoints)",
                icon: "star.circle.fill",
                color: .orange
            )

            StatTile(
                title: "Tasks",
                value: "\(member.tasksCompleted)",
                icon: "checkmark.circle.fill",
                color: .green
            )

            StatTile(
                title: "Streak",
                value: "\(member.currentStreak)",
                icon: "flame.fill",
                color: .red
            )
        }
    }
}

#Preview {

    ProfileView(
        member: HouseholdMember(
            name: "Rachel",
            points: 220
        )
    )
}
