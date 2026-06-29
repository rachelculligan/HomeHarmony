//
//  AddTaskView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/16/26.
//
import SwiftUI
import SwiftData

struct AddTaskView: View {

    @Environment(\.modelContext)
    private var context

    @Environment(\.dismiss)
    private var dismiss
    
    @Query
    private var members: [HouseholdMember]
    
    @State private var title = ""
    @State private var room = "Kitchen"
    @State private var estimatedMinutes = 5
    @State private var priority = 2
    @State private var isQuickWin = false
    @State private var dueDate = Date()
    @State private var selectedUsers: Set<String> = []
    @State private var frequency = "Weekly"
    
    @Environment(CurrentUserManager.self)
    private var currentUser

    let rooms = [
        "Kitchen",
        "Bathroom",
        "Living Room",
        "Bedroom",
        "Laundry Room",
        "Garage",
        "Outside"
    ]
    
    let frequencies = [
        "Daily",
        "Weekly",
        "Monthly",
        "As Needed"
    ]
    
    var body: some View {

        Form {

            Section("Task") {

                TextField(
                    "Task Name",
                    text: $title
                )
            }
            
            Section("Frequency") {

                Picker(
                    "Repeat",
                    selection: $frequency
                ) {

                    ForEach(
                        frequencies,
                        id: \.self
                    ) { item in

                        Text(item)
                    }
                }
            }

            Section("Location") {

                Picker("Room", selection: $room) {

                    ForEach(rooms, id: \.self) { room in
                        Text(room)
                    }
                }
            }
            
            Section("Schedule") {

                DatePicker(
                    "Due Date",
                    selection: $dueDate,
                    displayedComponents: .date
                )
            }
            
            Section("Effort") {

                Stepper(
                    "\(estimatedMinutes) minutes",
                    value: $estimatedMinutes,
                    in: 1...60
                )

                Toggle(
                    "Quick Win ⚡",
                    isOn: $isQuickWin
                )
            }

            Section("Priority") {

                Picker(
                    "Priority",
                    selection: $priority
                ) {

                    Text("Low").tag(1)
                    Text("Medium").tag(2)
                    Text("High").tag(3)
                }
                .pickerStyle(.segmented)
            }
            
            Section("Assign To") {

                ForEach(members) { member in

                    Toggle(
                        member.name,
                        isOn: Binding(
                            get: {
                                selectedUsers.contains(member.name)
                            },
                            set: { isSelected in

                                if isSelected {
                                    selectedUsers.insert(member.name)
                                } else {
                                    selectedUsers.remove(member.name)
                                }
                            }
                        )
                    )
                }
            }
            Button("Save Task") {

                if selectedUsers.isEmpty {

                    let task = CleaningTask(
                        title: title,
                        room: room,
                        frequency: frequency,
                        assignedUser: "Unassigned",
                        dueDate: dueDate,
                        estimatedMinutes: estimatedMinutes,
                        priority: priority,
                        isQuickWin: isQuickWin
                    )

                    context.insert(task)

                } else {

                    for user in selectedUsers {

                        let task = CleaningTask(
                            title: title,
                            room: room,
                            frequency: frequency,
                            assignedUser: user,
                            dueDate: dueDate,
                            estimatedMinutes: estimatedMinutes,
                            priority: priority,
                            isQuickWin: isQuickWin
                        )

                        context.insert(task)
                    }
                }

                try? context.save()

                dismiss()

                do {
                    try context.save()
                    print("Task saved successfully")
                } catch {
                    print("Save failed: \(error)")
                }

                dismiss()
            }
            .disabled(title.isEmpty)
        }

        .navigationTitle("New Task")
    }
}

#Preview {
    AddTaskView()
}
