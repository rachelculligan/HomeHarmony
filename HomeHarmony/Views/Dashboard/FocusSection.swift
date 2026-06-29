//
//  FocusSection.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/26/26.
//

import SwiftUI
import SwiftData

struct FocusSection: View {

    let tasks: [CleaningTask]

    let priorityColor: (Int) -> Color
    let onToggle: (CleaningTask) -> Void
    let onRemove: (CleaningTask) -> Void

    var body: some View {

        Section("🧠 Today's Focus") {

            if tasks.isEmpty {

                Text("No focus tasks")
                    .foregroundStyle(.secondary)

            } else {

                ForEach(tasks) { task in

                    HStack {

                        Button {

                            onToggle(task)

                        } label: {

                            Image(
                                systemName:
                                    task.completed
                                ? "checkmark.circle.fill"
                                : "circle"
                            )
                            .font(.title2)
                        }
                        .buttonStyle(.plain)

                        Button {

                            onRemove(task)

                        } label: {

                            Image(systemName: "minus.circle.fill")
                                .foregroundStyle(.red)

                        }
                        .buttonStyle(.plain)

                        NavigationLink {

                            EditTaskView(task: task)

                        } label: {

                            VStack(alignment: .leading) {

                                HStack {

                                    Circle()
                                        .fill(priorityColor(task.priority))
                                        .frame(width: 10, height: 10)

                                    Text(task.title)

                                }

                                Text("\(task.room) • \(task.assignedUser) • \(task.frequency)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
        }
    }
}
