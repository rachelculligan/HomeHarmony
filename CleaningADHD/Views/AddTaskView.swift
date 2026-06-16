//
//  AddTaskView.swift
//  CleaningADHD
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

    @State private var title = ""

    @State private var room = "Kitchen"

    @State private var estimatedMinutes = 5

    @State private var priority = 2

    @State private var isQuickWin = false

    let rooms = [
        "Kitchen",
        "Bathroom",
        "Living Room",
        "Bedroom",
        "Laundry Room",
        "Garage",
        "Outside"
    ]

    var body: some View {

        Form {

            Section("Task") {

                TextField(
                    "Task Name",
                    text: $title
                )
            }

            Section("Location") {

                Picker("Room", selection: $room) {

                    ForEach(rooms, id: \.self) { room in
                        Text(room)
                    }
                }
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

            Button("Save Task") {

                let task = CleaningTask(
                    title: title,
                    room: room,
                    frequency: "Weekly",
                    assignedUser: "Me",
                    dueDate: Date(),
                    estimatedMinutes: estimatedMinutes,
                    priority: priority,
                    isQuickWin: isQuickWin
                )

                context.insert(task)

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
