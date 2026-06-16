//
//  CleaningADHDApp.swift
//  CleaningADHD
//
//  Created by Rachel Culligan on 6/16/26.
//

import SwiftUI
import SwiftData

@main
struct CleaningADHDApp: App {

    var body: some Scene {
        WindowGroup {
            DashboardView()
        }
        .modelContainer(for: [
            CleaningTask.self,
            Household.self,
            CompletionRecord.self
        ])
    }
}

