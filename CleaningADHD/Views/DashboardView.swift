//
//  DashboardView.swift
//  CleaningADHD
//
//  Created by Rachel Culligan on 6/16/26.
//
import SwiftUI
import SwiftData
import Combine

struct DashboardView: View {
    @Query(sort: \CleaningTask.dueDate)
    private var tasks: [CleaningTask]
    
    @State private var showCelebration = false
    @State private var completedTaskName = ""
    @State private var rescueMode = false
    @State private var timeRemaining = 300
    
    
    var completedTasks: Int {
        tasks.filter { $0.completed }.count
    }
    
    var progress: Double {
        guard !tasks.isEmpty else { return 0 }
        return Double(completedTasks) / Double(tasks.count)
    }
    
    var currentStreak: Int {
        
        let completedDates = tasks
            .compactMap { $0.completedDate }
            .map { Calendar.current.startOfDay(for: $0) }
        
        let uniqueDays = Array(Set(completedDates))
            .sorted(by: >)
        
        guard !uniqueDays.isEmpty else { return 0 }
        
        var streak = 0
        var currentDay = Calendar.current.startOfDay(for: Date())
        
        for day in uniqueDays {
            
            if Calendar.current.isDate(day, inSameDayAs: currentDay) {
                
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
    private let timer = Timer.publish(
        every: 1,
        on: .main,
        in: .common
    ).autoconnect()
    
    var body: some View {
        
        NavigationStack {
            
            List {
                
                Section {
                    
                    VStack(spacing: 12) {
                        
                        Text("🔥 Current Streak")
                            .font(.headline)
                        
                        Text("\(currentStreak) Days")
                            .font(.largeTitle)
                            .bold()
                        
                        ProgressView(value: progress)
                        Button {
                            
                        rescueMode.toggle()
                            
                        } label: {
                            
                            Label(
                                rescueMode
                                ? "Exit Rescue Mode"
                                : "⚡ Start 5 Minute Rescue",
                                systemImage: "bolt.fill"
                            )
                        }
                        .buttonStyle(.borderedProminent)

                        if rescueMode {

                            Text(formatTime(timeRemaining))
                                .font(.largeTitle)
                                .bold()
                        }

                        Text("\(completedTasks) of \(tasks.count) tasks completed")                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                }
                Section("🧠 Today's Focus") {
                    
                    let focusTasks = rescueMode
                    ? tasks.filter {
                        !$0.completed &&
                        $0.isQuickWin
                    }.prefix(5)
                    
                    : tasks.filter {
                        !$0.completed
                    }.prefix(5)
                    
                    ForEach(Array(focusTasks)) { task in
                        
                        HStack {
                            
                            Button {
                                
                                if task.completed {
                                    
                                    task.completed = false
                                    task.completedDate = nil
                                    
                                } else {
                                    
                                    task.completed = true
                                    task.completedDate = Date()
                                    
                                    completedTaskName = task.title
                                    showCelebration = true
                                }
                                
                                try? task.modelContext?.save()
                            }
                            label: {
                                
                                Image(
                                    systemName:
                                        task.completed
                                    ? "checkmark.circle.fill"
                                    : "circle"
                                )
                                .font(.title2)
                            }
                            .buttonStyle(.plain)
                            
                            VStack(alignment: .leading) {
                                
                                Text(task.title)
                                
                                Text(task.room)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                Section("⚡ Quick Wins") {
                    
                    let quickWins = tasks.filter { $0.isQuickWin }
                    
                    if quickWins.isEmpty {
                        
                        Text("No quick wins yet")
                            .foregroundStyle(.secondary)
                        
                    } else {
                        
                        ForEach(quickWins) { task in
                            
                            HStack {
                                
                                Image(systemName: "bolt.fill")
                                
                                Text(task.title)
                            }
                        }
                    }
                }
                Section("✅ Completed") {
                    
                    let completed = tasks.filter { $0.completed }
                    
                    if completed.isEmpty {
                        
                        Text("Nothing completed yet")
                            .foregroundStyle(.secondary)
                        
                    } else {
                        
                        ForEach(completed) { task in
                            
                            HStack {
                                
                                Image(systemName: "checkmark.circle.fill")
                                
                                Text(task.title)
                            }
                        }
                    }
                }
            }
            .navigationTitle("CleaningADHD")
            .onReceive(timer) { _ in
                
                guard rescueMode else { return }
                
                if timeRemaining > 0 {
                    
                    timeRemaining -= 1
                    
                } else {
                    
                    rescueMode = false
                    
                    completedTaskName = "5 Minute Rescue Completed"
                    showCelebration = true
                    
                    timeRemaining = 300
                }
            }
            .toolbar {
                
                NavigationLink {
                    AddTaskView()
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            .alert(
                "🎉 Great Job!",
                isPresented: $showCelebration
            ) {
                Button("Awesome") { }
            } message: {
                Text("You completed: \(completedTaskName)")
            }
        }
    }
    func formatTime(_ seconds: Int) -> String {
        
        let minutes = seconds / 60
        let seconds = seconds % 60
        
        return String(
            format: "%02d:%02d",
            minutes,
            seconds
        )
    }
}
#Preview {
    DashboardView()
}
