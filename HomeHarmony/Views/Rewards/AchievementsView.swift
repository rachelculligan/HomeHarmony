//
//  AchievementsView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/26/26.
//

import SwiftUI
import SwiftData

struct AchievementsView: View {

    @Query
    private var achievements: [Achievement]

    var body: some View {

        NavigationStack {

            List {

                ForEach(achievements) { achievement in

                    HStack {

                        Image(systemName: achievement.icon)
                            .font(.largeTitle)
                            .foregroundStyle(
                                achievement.unlocked
                                ? .yellow
                                : .gray
                            )

                        VStack(alignment: .leading) {

                            Text(achievement.title)
                                .font(.headline)

                            Text(achievement.details)
                                .font(.caption)

                            Text("+\(achievement.points) ⭐")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        if achievement.unlocked {

                            Image(systemName: "checkmark.seal.fill")
                                .foregroundStyle(.green)
                        }
                    }
                    .padding(.vertical, 6)
                }
            }
            .navigationTitle("Achievements")
        }
    }
}

#Preview {
    AchievementsView()
}
