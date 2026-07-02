//
//  AvatarView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/29/26.
//

import SwiftUI

struct AvatarView: View {

    let member: HouseholdMember
    var size: CGFloat = 52

    var body: some View {

        ZStack {

            Circle()
                .fill(color)
                .frame(width: size, height: size)

            Image(systemName: member.avatar)
                .foregroundStyle(.white)
                .font(.system(size: size * 0.4))
        }
    }

    private var color: Color {

        switch member.color.lowercased() {

        case "red":
            return .red

        case "green":
            return .green

        case "orange":
            return .orange

        case "purple":
            return .purple

        case "pink":
            return .pink

        default:
            return HomeHarmonyTheme.primary
        }
    }
}

#Preview {

    AvatarView(
        member: HouseholdMember(
            name: "Rachel"
        )
    )
}
