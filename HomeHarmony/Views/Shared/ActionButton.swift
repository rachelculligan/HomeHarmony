//
//  ActionButton.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/29/26.
//

import SwiftUI

struct ActionButton: View {

    let title: String
    let icon: String
    let color: Color
    let action: () -> Void

    var body: some View {

        Button(action: action) {

            ActionButtonLabel(
                title: title,
                icon: icon,
                color: color
            )
        }
        .buttonStyle(.plain)
    }
}
