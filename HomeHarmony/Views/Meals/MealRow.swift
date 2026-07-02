//
//  MealRow.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 7/1/26.
//


import SwiftUI

struct MealRow: View {

    let icon: String
    let title: String
    let meal: String?
    var action: (() -> Void)?

    var body: some View {

        Button {

            action?()

        } label: {

            HStack {

                Image(systemName: icon)
                    .frame(width: 24)

                Text(title)

                Spacer()

                Text(meal ?? "Choose \(title)")
                    .foregroundStyle(meal == nil ? HomeHarmonyTheme.primary : .primary)

                Image(systemName: "chevron.right")
                    .foregroundStyle(.tertiary)
            }
        }
        .buttonStyle(.plain)
    }
}
