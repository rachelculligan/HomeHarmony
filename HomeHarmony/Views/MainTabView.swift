//
//  MainTabView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/17/26.
//

import SwiftUI

struct MainTabView: View {

    var body: some View {

        TabView {

            DashboardView()
                .tabItem {

                    Label(
                        "Dashboard",
                        systemImage: "house.fill"
                    )
                }

            CalendarView()
                .tabItem {

                    Label(
                        "Calendar",
                        systemImage: "calendar"
                    )
                }
            
            AchievementsView()
                .tabItem {

                    Label(
                        "Achievements",
                        systemImage: "medal.fill"
                    )
                }
            
            RewardsView()
                .tabItem {

                    Label(
                        "Rewards",
                        systemImage: "gift.fill"
                    )
                }
            
            StatsView()
                .tabItem {

                    Label(
                        "Stats",
                        systemImage: "chart.bar.fill"
                    )
                }
            
            HouseholdView()
                .tabItem {

                    Label(
                        "Household",
                        systemImage: "person.3.fill"
                    )
                }
            
            SettingsView()
                .tabItem {

                    Label(
                        "Settings",
                        systemImage: "gearshape.fill"
                    )
                }
            
        }
    }
}

#Preview {
    MainTabView()
}
