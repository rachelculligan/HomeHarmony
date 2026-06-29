//
//  StatsView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/18/26.
//

import SwiftUI
import SwiftData

struct StatsView: View {
    
    @Query
    private var tasks: [CleaningTask]
    
    @Query
    private var members: [HouseholdMember]
    
    @Query
    private var completionRecords: [CompletionRecord]
    
    @Environment(\.modelContext)
    private var context
    
    @State private var showResetAlert = false
    
    func resetStats() {

        for task in tasks {

            task.completed = false
            task.completedDate = nil
            task.todayFocus = false
        }

        try? context.save()
    }
    
    var leaderboard: [(String, Int)] {

        members
            .map { member in
                (member.name, member.points)
            }
            .sorted {
                $0.1 > $1.1
            }
    }
    
    var completedCount: Int {
        completionRecords.count
    }
    
    var quickWinsCompleted: Int {
        tasks.filter {
            $0.completed &&
            $0.isQuickWin
        }.count
    }
    
    var completedToday: Int {

        completionRecords.filter {

            Calendar.current.isDateInToday(
                $0.completedDate
            )

        }.count
    }
    
    var completedThisWeek: Int {

        completionRecords.filter {

            Calendar.current.isDate(
                $0.completedDate,
                equalTo: Date(),
                toGranularity: .weekOfYear
            )

        }.count
    }
    
    @Query
    private var households: [Household]

    var weeklyGoal: Int {
        households.first?.weeklyGoal ?? 50
    }
    
    
    var currentStreak: Int {
        
        let dates = tasks
            .compactMap { $0.completedDate }
            .map {
                Calendar.current.startOfDay(for: $0)
            }
        
        let uniqueDays = Array(Set(dates))
            .sorted(by: >)
        
        guard !uniqueDays.isEmpty else {
            return 0
        }
        
        var streak = 0
        var currentDay =
        Calendar.current.startOfDay(
            for: Date()
        )
        
        for day in uniqueDays {
            
            if Calendar.current.isDate(
                day,
                inSameDayAs: currentDay
            ) {
                
                streak += 1
                
                currentDay =
                Calendar.current.date(
                    byAdding: .day,
                    value: -1,
                    to: currentDay
                ) ?? currentDay
                
            } else {
                break
            }
        }
        
        return streak
    }
    var achievements: [String] {

        var badges: [String] = []

        if completedCount >= 1 {
            badges.append("🥇 First Task Complete")
        }

        if completedCount >= 25 {
            badges.append("🧹 Cleaning Machine")
        }

        if completedCount >= 100 {
            badges.append("🏠 Household Hero")
        }

        if quickWinsCompleted >= 10 {
            badges.append("⚡ Quick Win Master")
        }

        if currentStreak >= 7 {
            badges.append("🔥 7 Day Streak")
        }

        if currentStreak >= 30 {
            badges.append("👑 Consistency Champion")
        }

        return badges
    }
    
    var nextAchievement: String {

        if completedCount < 25 {
            return "\(completedCount)/25 → 🧹 Cleaning Machine"
        }

        if completedCount < 100 {
            return "\(completedCount)/100 → 🏠 Household Hero"
        }

        if currentStreak < 7 {
            return "\(currentStreak)/7 → 🔥 7 Day Streak"
        }

        return "All current achievements unlocked!"
    }
    
    var body: some View {
        
        NavigationStack {
            
            List {
                Section {
                    
                    VStack(spacing: 12) {
                        
                        Text("🔥 \(currentStreak) Day Streak")
                            .font(.largeTitle)
                            .bold()
                        
                        Text(
                            "\(completedToday) completed today"
                        )
                        .foregroundStyle(.secondary)
                        
                        Text(
                            "\(completedThisWeek) completed this week"
                        )
                        .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                }
                Section("📊 Overview") {
                    
                    HStack {
                        Text("Tasks Completed")
                        Spacer()
                        Text("\(completedCount)")
                            .bold()
                    }
                    HStack {
                        
                        Text("Current Streak")
                        
                        Spacer()
                        
                        Text("🔥 \(currentStreak)")
                            .bold()
                    }
                    HStack {
                        Text("Quick Wins Completed")
                        Spacer()
                        Text("\(quickWinsCompleted)")
                            .bold()
                    }
                    
                    HStack {
                        
                        Text("Completed Today")
                        
                        Spacer()
                        
                        Text("\(completedToday)")
                            .bold()
                    }
                    
                    HStack {
                        
                        Text("Completed This Week")
                        
                        Spacer()
                        
                        Text("\(completedThisWeek)")
                            .bold()
                    }
                }
                
                Section("🎯 Next Goal") {

                    Text(nextAchievement)
                        .font(.headline)
                }
                
                
                Section("🎯 Family Challenge") {

                    ProgressView(
                        value: Double(completedThisWeek),
                        total: Double(weeklyGoal)
                    )

                    Text(
                        "\(completedThisWeek) / \(weeklyGoal) tasks completed this week"
                    )

                    if completedThisWeek >= weeklyGoal {

                        Text("🎉 Challenge Complete!")
                            .bold()

                    } else {

                        Text(
                            "\(weeklyGoal - completedThisWeek) tasks to go"
                        )
                        .foregroundStyle(.secondary)
                    }
                }
                
                Section("🏅 Achievements") {

                    if achievements.isEmpty {

                        Text("No achievements yet")
                            .foregroundStyle(.secondary)

                    } else {

                        ForEach(
                            achievements,
                            id: \.self
                        ) { badge in

                            Label(
                                badge,
                                systemImage: "rosette"
                            )
                        }
                    }
                }
                
                Section("📜 Recent Activity") {

                    let recentRecords = completionRecords
                        .sorted {
                            $0.completedDate > $1.completedDate
                        }

                    if recentRecords.isEmpty {

                        Text("No activity yet")
                            .foregroundStyle(.secondary)

                    } else {

                        ForEach(
                            recentRecords.prefix(10),
                            id: \.id
                        ) { record in

                            VStack(alignment: .leading) {

                                Text(
                                    "\(record.completedBy) completed \(record.taskName)"
                                )

                                Text(
                                    record.completedDate.formatted(
                                        date: .abbreviated,
                                        time: .shortened
                                    )
                                )
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                
                Section("🛠 Debug Records") {

                    Text("Records: \(completionRecords.count)")
                }
                Section("🏆 Top Cleaners") {
                    
                    if leaderboard.isEmpty {
                        
                        Text("No data yet")
                            .foregroundStyle(.secondary)
                        
                    } else {
                        
                        ForEach(
                            leaderboard,
                            id: \.0
                        ) { person, score in
                            
                            HStack {
                                
                                HStack {

                                    if leaderboard.first?.0 == person {

                                        Text("🥇 \(person)")

                                    } else if leaderboard.count > 1 &&
                                                leaderboard[1].0 == person {

                                        Text("🥈 \(person)")

                                    } else if leaderboard.count > 2 &&
                                                leaderboard[2].0 == person {

                                        Text("🥉 \(person)")

                                    } else {

                                        Text(person)
                                    }

                                    Spacer()

                                    Text("⭐ \(score)")
                                        .bold()
                                }
                                
                                Spacer()
                                
                                Text("\(score)")
                                    .bold()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Statistics")
            
            .toolbar {

                Button("Reset Stats") {

                    showResetAlert = true
                }
            }
            .alert(
                "Reset Statistics?",
                isPresented: $showResetAlert
            ) {

                Button(
                    "Reset",
                    role: .destructive
                ) {

                    resetStats()
                }

                Button(
                    "Cancel",
                    role: .cancel
                ) { }

            } message: {

                Text(
                    "This will clear all completions, streaks, and leaderboard scores."
                )
            }
        }
    }
}

#Preview {
    StatsView()
}
