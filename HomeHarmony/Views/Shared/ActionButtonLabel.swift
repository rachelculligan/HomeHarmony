//
//  ActionButtonLabel.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/29/26.
//

import SwiftUI

struct ActionButtonLabel: View {

    let title: String
    let icon: String
    let color: Color

    var body: some View {

        VStack(spacing: 12) {

            Image(systemName: icon)
                .font(.system(size: 26))
                .foregroundStyle(.white)
                .frame(width: 58, height: 58)
                .background(color.gradient)
                .clipShape(Circle())

            Text(title)
                .font(.caption.bold())
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
