//
//  DashboardActions.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/29/26.
//

import SwiftUI
import SwiftData

extension DashboardView {

    

    func formatTime(_ seconds: Int) -> String {

        String(
            format: "%02d:%02d",
            seconds / 60,
            seconds % 60
        )
    }
}
