//
//  EditTaskView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/18/26.
//

import SwiftUI
import SwiftData

struct EditTaskView: View {

    @Bindable var task: CleaningTask

    @Environment(\.dismiss)
    private var dismiss
    
    @Environment(\.modelContext)
    private var context
    
    @Query
    private var members: [HouseholdMember]

    var body: some View {

        Form {

            Section("Task") {

                TextField(
                    "Task Name",
                    text: $task.title
                )
            }

            Section("Location") {

                TextField(
                    "Room",
                    text: $task.room
                )
            }

            Section("Assignment") {

                Picker(
                    "Assigned To",
                    selection: $task.assignedUser
                ) {

                    ForEach(members) { member in

                        Text(member.name)
                            .tag(member.name)
                    }
                }
            }

            Section("Frequency") {

                Picker(
                    "Frequency",
                    selection: $task.frequency
                ) {

                    Text("Daily").tag("Daily")
                    Text("Weekly").tag("Weekly")
                    Text("Monthly").tag("Monthly")
                    Text("As Needed").tag("As Needed")
                }
                .pickerStyle(.segmented)
            }
            
            Section("Effort") {

                Stepper(
                    "\(task.estimatedMinutes) minutes",
                    value: $task.estimatedMinutes,
                    in: 1...120
                )

                Toggle(
                    "Quick Win ⚡",
                    isOn: $task.isQuickWin
                )
            }

            Section("Priority") {

                Picker(
                    "Priority",
                    selection: $task.priority
                ) {

                    Text("Low").tag(1)
                    Text("Medium").tag(2)
                    Text("High").tag(3)
                }
                .pickerStyle(.segmented)
            }
            Section {

                Button(
                    "Delete Task",
                    role: .destructive
                ) {

                    context.delete(task)

                    try? context.save()

                    dismiss()
                }
            }
            Button("Done") {

                dismiss()
            }
        }
        .navigationTitle("Edit Task")
    }
}

#Preview {
    EditTaskView(
        task: CleaningTask(
            title: "Sample Task",
            room: "Kitchen",
            frequency: "Weekly",
            assignedUser: "Sample User",
            dueDate: Date()
        )
    )
}
