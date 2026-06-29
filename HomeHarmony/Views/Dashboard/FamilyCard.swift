//
//  FamilyCard.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/29/26.
//

import SwiftUI

struct FamilyCard: View {

    let members: [HouseholdMember]

    private var sortedMembers: [HouseholdMember] {
        members.sorted { $0.points > $1.points }
    }

    private var totalPoints: Int {
        members.reduce(0) { $0 + $1.points }
    }

    private func medal(for index: Int) -> String {
        switch index {
        case 0: return "👑"
        case 1: return "🥈"
        case 2: return "🥉"
        default: return "⭐️"
        }
    }

    var body: some View {

        PrimaryCard {

            SectionHeader(
                title: "Family",
                icon: "person.3.fill"
            )

            VStack(spacing: 14) {

                ForEach(Array(sortedMembers.enumerated()), id: \.element.id) { index, member in

                    HStack {

                        Text(medal(for: index))
                            .font(.title2)

                        VStack(alignment: .leading) {

                            Text(member.name)
                                .font(.headline)

                            Text("\(member.points) points")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        Text("⭐️ \(member.points)")
                            .bold()
                    }
                }

                Divider()

                HStack {

                    Text("Family Total")

                    Spacer()

                    Text("⭐️ \(totalPoints)")
                        .font(.headline)
                }
            }
        }
    }
}
