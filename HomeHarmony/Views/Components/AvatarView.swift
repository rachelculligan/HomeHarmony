//
//  AvatarView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/29/26.
//

import SwiftUI

struct AvatarView: View {

    let name: String
    let color: Color

    var body: some View {

        Circle()
            .fill(color.gradient)
            .frame(width: 70, height: 70)
            .overlay {

                Text(String(name.prefix(1)))
                    .font(.title.bold())
                    .foregroundStyle(.white)

            }
            .overlay {

                Circle()
                    .stroke(.white, lineWidth: 3)

            }
            .shadow(radius: 5)
    }
}
