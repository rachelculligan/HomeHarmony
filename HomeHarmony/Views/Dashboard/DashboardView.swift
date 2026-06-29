//
//  DashboardView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/16/26.
//
import SwiftUI
import SwiftData
import Combine

struct DashboardView: View {
    
    @Environment(\.modelContext)
    private var context
    
    @Query private var tasks: [CleaningTask]
    @Query private var members: [HouseholdMember]
    @Query private var households: [Household]
    @Query private var challenges: [FamilyChallenge]

    @State private var showCelebration = false
    @State private var completedTaskName = ""
    @State private var rescueMode = false
    @State private var timeRemaining = 300
    @State private var selectedTimeBudget: Int?
    @State private var energyLevel = 2
    @State private var selectedRoom: String?
    @State private var showTemplateChooser = false
    @State private var selectedUser = "All"
    
    @AppStorage("currentUser")
    private var currentUser = "Rachel"
    

    private let timer = Timer.publish(
        every: 1,
        on: .main,
        in: .common
    ).autoconnect()
   
    var overdueCount: Int {
        overdueTasks.count
    }
    
    var dueTodayCount: Int {
        dueTodayTasks.count
    }
    
    var focusCount: Int {
        focusTasks.count
    }
    
    var currentChallenge: FamilyChallenge? {
        challenges.first
    }
    
    
    var completedTasks: Int {
        filteredTasks.filter { $0.completed }.count
    }
    
    var progress: Double {
        guard !tasks.isEmpty else { return 0 }
        return Double(completedTasks) / Double(tasks.count)
    }
    
    var filteredTasks: [CleaningTask] {

        if selectedUser == "All" {
            return tasks
        }

        return tasks.filter {
            $0.assignedUser == selectedUser
        }
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
    
    
    var recommendedTasks: [CleaningTask] {
        guard let budget = selectedTimeBudget else {
            return []
        }
        
        var remaining = budget
        
        let availableTasks: [CleaningTask]
        
        switch energyLevel {
            
        case 1:
            
            availableTasks = filteredTasks.filter {
                !$0.completed &&
                $0.isQuickWin &&
                $0.estimatedMinutes <= 5
            }
            
        case 3:
            
            availableTasks = filteredTasks.filter {
                !$0.completed
            }
            
        default:
            
            availableTasks = filteredTasks.filter {
                !$0.completed
            }
        }
        
        let sortedTasks = availableTasks.sorted {
            $0.priority > $1.priority
        }
        
        var selected: [CleaningTask] = []
        
        for task in sortedTasks {
            
            if task.estimatedMinutes <= remaining {
                
                selected.append(task)
                
                remaining -= task.estimatedMinutes
            }
        }
        
        return selected
    }
    
    var roomTasks: [CleaningTask] {
        
        guard let room = selectedRoom else {
            return []
        }
        
        return tasks
            .filter {
                !$0.completed &&
                $0.room == room
            }
            .sorted {
                $0.priority > $1.priority
            }
    }
    
    var focusTasks: [CleaningTask] {
        
        if rescueMode {
            
            return Array(
                filteredTasks
                    .filter {
                        !$0.completed &&
                        $0.isQuickWin
                    }
                    .prefix(5)
            )
            
        } else {
            
            return filteredTasks.filter {
                
                !$0.completed && (
                    
                    $0.todayFocus ||
                    
                    $0.assignedUser == selectedUser
                )
            }
        }
    }
    
    var dueTodayTasks: [CleaningTask] {
        
        filteredTasks.filter {
            
            !$0.completed &&
            Calendar.current.isDateInToday(
                $0.dueDate
            )
        }
    }
    
    var overdueTasks: [CleaningTask] {
        filteredTasks.filter {
            !$0.completed &&
            $0.dueDate < Date() &&
            !Calendar.current.isDateInToday($0.dueDate)
        }
    }

    var body: some View {

        NavigationStack {

            ScrollView {

                LazyVStack(spacing: 20) {

                    WelcomeCard(
                        householdName: households.first?.name ?? "My Home",
                        userName: currentUser,
                        tasksRemaining: dueTodayTasks.count
                    )

                    FamilyCard(
                        members: members
                    )

                    QuickActionsCard {

                        showTemplateChooser = true
                    }

                    ProgressCard(
                        streak: currentStreak,
                        progress: progress,
                        completed: completedTasks,
                        total: tasks.count
                    )

                    TodayCard(
                        tasks: dueTodayTasks,
                        priorityColor: priorityColor
                    ) { task in

                        completeTask(task)
                    }

                    OverdueSection(
                        tasks: overdueTasks,
                        priorityColor: priorityColor
                    ) { task in

                        completeTask(task)
                    }
                }
                .padding()
            }
            .scrollContentBackground(.hidden)
            .background(Color(.systemGroupedBackground))
            .navigationTitle("HomeHarmony")
            .toolbar {

                ToolbarItemGroup(
                    placement: .topBarTrailing
                ) {
                    Button {
                        showTemplateChooser = true
                    } label: {
                        Image(systemName: "list.bullet.clipboard")
                    }
                    NavigationLink {
                        AddTaskView()
                    } label: {
                        Image(systemName: "plus")
                    }
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
            .sheet(
                isPresented: $showTemplateChooser
            ) {
                TemplateChooserView { template in
                    loadTemplate(template)
                }
            }
        }
    }
                func loadTemplate(
                    _ template: CleaningTemplate
                ) {
                    
                    for item in template.tasks {
                        
                        let exists = tasks.contains {
                            $0.title == item.title &&
                            $0.room == item.room
                        }
                        
                        if exists {
                            continue
                        }
                        
                        let task = CleaningTask(
                            title: item.title,
                            room: item.room,
                            frequency: "Daily",
                            assignedUser: currentUser,
                            dueDate: Date(),
                            estimatedMinutes: item.minutes,
                            priority: 2,
                            isQuickWin: item.minutes <= 5,
                            todayFocus: item.minutes <= 5
                        )
                        
                        context.insert(task)
                    }
                    
                    do {
                        
                        try context.save()
                        completedTaskName = "\(template.name) loaded successfully"
                        showCelebration = true
                        print("✅ Template loaded successfully")
                        print("✅ Tasks inserted: \(template.tasks.count)")
                        
                    } catch {
                        
                        print("❌ Template save failed")
                        print(error)
                    }
                }
    func priorityColor(_ priority: Int) -> Color {

        switch priority {

        case 3:
            return .red

        case 2:
            return .orange

        default:
            return .green
        }
    }

    private func completeTask(_ task: CleaningTask) {

        let earnedPoints = TaskService.toggleComplete(
            task: task,
            context: context
        )

        guard earnedPoints else { return }

        RewardService.awardPoints(
            to: task.assignedUser,
            amount: 10,
            members: members,
            context: context
        )

        completedTaskName = task.title
        showCelebration = true
    }

} // DashboardView

#Preview {
    DashboardView()
}
