//
//  HomeHarmonyApp.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/16/26.
//

import SwiftUI
import SwiftData

@main
struct HomeHarmonyApp: App {

    @State
    private var currentUser = CurrentUserManager()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(currentUser)
        }
        .modelContainer(for: [
            CleaningTask.self,
            Household.self,
            CompletionRecord.self,
            HouseholdMember.self,
            Reward.self,
            RewardRedemption.self,
            FamilyChallenge.self,
            Achievement.self
        ])
    }
}

