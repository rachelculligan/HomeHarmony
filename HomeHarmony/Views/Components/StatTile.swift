//
//  StatTile.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/30/26.
//

import SwiftUI

struct StatTile: View {

    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {

        VStack(spacing: 10) {

            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)

            Text(value)
                .font(.title.bold())

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()

        .background(HomeHarmonyTheme.cardBackground)

        .clipShape(
            RoundedRectangle(
                cornerRadius: HomeHarmonyStyle.mediumRadius
            )
        )
    }
}
