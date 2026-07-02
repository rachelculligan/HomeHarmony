//
//  LeaderboardView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/30/26.
//

import SwiftUI
import SwiftData

struct LeaderboardView: View {

    @Query(sort: \HouseholdMember.points, order: .reverse)
    private var members: [HouseholdMember]

    private var totalPoints: Int {
        members.reduce(0) { $0 + $1.points }
    }

    var body: some View {

        NavigationStack {

            List {

                Section {

                    ForEach(Array(members.enumerated()), id: \.element.id) { index, member in

                        HStack(spacing: 16) {

                            ZStack {

                                Circle()
                                    .fill(color(for: member.color))
                                    .frame(width: 52, height: 52)

                                Image(systemName: member.avatar)
                                    .foregroundStyle(.white)
                            }

                            VStack(alignment: .leading, spacing: 8) {

                                HStack {

                                    Text(rank(index))

                                    Text(member.name)
                                        .font(.headline)
                                }

                                XPBadge(
                                    level: member.level,
                                    experience: member.experience,
                                    experienceNeeded: member.experienceNeeded
                                )
                            }

                            Spacer()

                            VStack(alignment: .trailing) {

                                Text("\(member.points)")
                                    .font(.title3.bold())

                                Label("XP", systemImage: "star.fill")
                                    .font(.caption)
                                    .foregroundStyle(.yellow)
                            }
                        }
                        .padding(.vertical, 6)
                    }

                } footer: {

                    HStack {

                        Text("Family Total")

                        Spacer()

                        Text("\(totalPoints) XP")
                            .bold()
                    }
                }
            }
            .navigationTitle("Leaderboard")
        }
    }

    private func rank(_ index: Int) -> String {

        switch index {

        case 0: return "👑"
        case 1: return "🥈"
        case 2: return "🥉"
        default: return "⭐️"
        }
    }

    private func level(for points: Int) -> String {

        let level = (points / 100) + 1
        return "Level \(level)"
    }

    private func color(for color: String) -> Color {

        switch color.lowercased() {

        case "red": return .red
        case "green": return .green
        case "orange": return .orange
        case "purple": return .purple
        case "pink": return .pink
        default: return .blue
        }
    }
}

#Preview {

    LeaderboardView()
}
