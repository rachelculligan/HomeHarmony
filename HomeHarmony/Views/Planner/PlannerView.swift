
//
//  PlannerView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/29/26.
//
import SwiftUI
import SwiftData

struct PlannerView: View {

    @Environment(\.modelContext)
    private var context

    @Query
    private var tasks: [CleaningTask]

    @Query
    private var members: [HouseholdMember]

    @Query
    private var challenges: [FamilyChallenge]

    @AppStorage("currentUser")
    private var currentUser = "Rachel"

    @State private var selectedUser = "All"
    @State private var selectedRoom: String?
    @State private var selectedTimeBudget: Int?
    @State private var energyLevel = 2

    var filteredTasks: [CleaningTask] {

        if selectedUser == "All" {
            return tasks
        }

        return tasks.filter {
            $0.assignedUser == selectedUser
        }
    }

    var recommendedTasks: [CleaningTask] {

        guard let budget = selectedTimeBudget else {
            return []
        }

        var remaining = budget

        let available = filteredTasks
            .filter { !$0.completed }
            .sorted { $0.priority > $1.priority }

        var result: [CleaningTask] = []

        for task in available {

            if task.estimatedMinutes <= remaining {

                result.append(task)
                remaining -= task.estimatedMinutes
            }
        }

        return result
    }

    var roomTasks: [CleaningTask] {

        guard let selectedRoom else { return [] }

        return tasks
            .filter {
                !$0.completed &&
                $0.room == selectedRoom
            }
            .sorted {
                $0.priority > $1.priority
            }
    }

    var body: some View {

        NavigationStack {

            Form {

                Section("Current User") {

                    Picker("User", selection: $currentUser) {

                        ForEach(members) { member in

                            Text(member.name)
                                .tag(member.name)
                        }
                    }
                }

                Section("Assigned To") {

                    Picker("Person", selection: $selectedUser) {

                        Text("All")
                            .tag("All")

                        ForEach(members) { member in

                            Text(member.name)
                                .tag(member.name)
                        }
                    }
                }

                Section("Energy Level") {

                    Picker(
                        "Energy",
                        selection: $energyLevel
                    ) {

                        Text("😴").tag(1)
                        Text("🙂").tag(2)
                        Text("🚀").tag(3)
                    }
                    .pickerStyle(.segmented)
                }

                Section("Time Available") {

                    HStack {

                        Button("5") {
                            selectedTimeBudget = 5
                        }

                        Button("10") {
                            selectedTimeBudget = 10
                        }

                        Button("15") {
                            selectedTimeBudget = 15
                        }

                        Button("30") {
                            selectedTimeBudget = 30
                        }
                    }

                    ForEach(recommendedTasks) { task in

                        HStack {

                            Text(task.title)

                            Spacer()

                            Text("\(task.estimatedMinutes)m")
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                Section("Room Reset") {

                    ScrollView(.horizontal) {

                        HStack {

                            ForEach(
                                [
                                    "Kitchen",
                                    "Bathroom",
                                    "Living Room",
                                    "Bedroom",
                                    "Laundry Room",
                                    "Garage",
                                    "Outside"
                                ],
                                id: \.self
                            ) { room in

                                Button(room) {

                                    selectedRoom = room

                                }
                                .buttonStyle(.bordered)
                            }
                        }
                    }

                    ForEach(roomTasks) { task in

                        HStack {

                            Text(task.title)

                            Spacer()

                            Button("Focus") {

                                task.todayFocus = true

                                try? context.save()
                            }
                        }
                    }
                }

                Section("Weekly Challenge") {

                    if let challenge = challenges.first {

                        let completed = tasks.filter {

                            $0.completedDate != nil &&
                            $0.completedDate! >= challenge.startDate

                        }.count

                        ProgressView(
                            value: Double(completed),
                            total: Double(challenge.goal)
                        )

                        Text("\(completed) / \(challenge.goal)")
                    }
                    else {

                        Button("Create Challenge") {

                            context.insert(
                                FamilyChallenge(
                                    title: "Family Sprint",
                                    goal: 50,
                                    reward: "Pizza Night 🍕"
                                )
                            )

                            try? context.save()
                        }
                    }
                }
            }
            .navigationTitle("Planner")
        }
    }
}

#Preview {

    PlannerView()
}


