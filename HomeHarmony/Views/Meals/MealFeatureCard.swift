//
//  MealFeatureCard.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 7/1/26.
//


import SwiftUI

struct MealFeatureCard<Destination: View>: View {

    let title: String
    let subtitle: String
    let icon: String
    let destination: Destination

    var body: some View {

        NavigationLink {

            destination

        } label: {

            PrimaryCard {

                HStack(spacing: 18) {

                    ZStack {

                        Circle()
                            .fill(HomeHarmonyTheme.primary.opacity(0.15))
                            .frame(width: 56, height: 56)

                        Image(systemName: icon)
                            .font(.title2)
                            .foregroundStyle(HomeHarmonyTheme.primary)
                    }

                    VStack(alignment: .leading, spacing: 4) {

                        Text(title)
                            .font(.headline)

                        Text(subtitle)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundStyle(.tertiary)
                }
            }
        }
        .buttonStyle(.plain)
    }
}
