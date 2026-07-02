//
//  PrimaryCard.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/29/26.
//

import SwiftUI

struct PrimaryCard<Content: View>: View {

    @ViewBuilder
    let content: Content

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            content

        }
        .cornerRadius(HomeHarmonyStyle.mediumRadius)
        .padding(HomeHarmonyStyle.mediumPadding)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(
                cornerRadius: 24,
                style: .continuous
            )
            .fill(Color(.systemBackground))
        )
        .shadow(
            color: .black.opacity(0.08),
            radius: 12,
            y: 6
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: 24,
                style: .continuous
            )
        )
        .shadow(
            color: .black.opacity(0.08),
            radius: 10,
            y: 4
        )
    }
}
