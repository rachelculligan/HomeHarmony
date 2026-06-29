//
//  SectionHeader.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/29/26.
//

import SwiftUI

struct SectionHeader: View {

    let title: String
    let icon: String

    var body: some View {

        HStack {

            Image(systemName: icon)

            Text(title)
                .font(.title3)
                .bold()

            Spacer()
        }
    }
}
