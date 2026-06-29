//
//  DueTodaySection.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/26/26.
//

import SwiftUI
import SwiftData

struct DueTodaySection: View {

    let tasks: [CleaningTask]

    let priorityColor: (Int) -> Color
    let onToggle: (CleaningTask) -> Void

    var body: some View {

        Section("📅 Due Today") {

            if tasks.isEmpty {

                Text("Nothing due today 🎉")
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

                        NavigationLink {

                            EditTaskView(task: task)

                        } label: {

                            HStack {

                                Circle()
                                    .fill(priorityColor(task.priority))
                                    .frame(width: 10, height: 10)

                                VStack(alignment: .leading) {

                                    Text(task.title)

                                    Text(task.assignedUser)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }

                                Spacer()

                                Text(task.dueDate, style: .date)
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
        }
    }
}

