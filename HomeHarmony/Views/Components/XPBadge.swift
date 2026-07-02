//
//  XPBadge.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/30/26.
//

import SwiftUI

struct XPBadge: View {

    let level: Int
    let experience: Int
    let experienceNeeded: Int

    private var progress: Double {
        Double(experience) / Double(experienceNeeded)
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 8) {

            HStack {

                Image(systemName: "star.circle.fill")
                    .foregroundStyle(.yellow)

                Text("Level \(level)")
                    .font(.headline)
            }

            ProgressView(value: progress)
                .tint(.green)
                .animation(
                    .spring(
                        response: 0.5,
                        dampingFraction: 0.8
                    ),
                    value: experience
                )

            Text("\(experience) / \(experienceNeeded) XP")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {

    XPBadge(
        level: 4,
        experience: 160,
        experienceNeeded: 250
    )
}
