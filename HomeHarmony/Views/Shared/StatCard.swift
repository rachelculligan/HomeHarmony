//
//  StatCard.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/26/26.
//

import SwiftUI

struct StatCard: View {

    let icon: String
    let title: String
    let value: String
    let color: Color

    var body: some View {

        VStack(alignment: .leading, spacing: 10) {

            HStack {

                Image(systemName: icon)

                Text(title)
                    .font(.headline)
            }

            Text(value)
                .font(.largeTitle)
                .bold()

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()

        .background(color.opacity(0.15))

        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
    }
}

