//
//  OverdueSection.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/25/26.
//

import SwiftUI

struct OverdueSection: View {

    let tasks: [CleaningTask]
    let priorityColor: (Int) -> Color
    let onComplete: (CleaningTask) -> Void

    var body: some View {

        PrimaryCard {

            SectionHeader(
                title: "⚠️ Overdue",
                icon: "exclamationmark.triangle.fill"
            )

            if tasks.isEmpty {

                Text("No overdue tasks 🎉")
                    .foregroundStyle(.secondary)

            } else {

                ForEach(tasks) { task in

                    HStack {

                        Button {
                            onComplete(task)
                        } label: {

                            Image(systemName:
                                task.completed
                                ? "checkmark.circle.fill"
                                : "circle"
                            )
                            .font(.title2)
                        }
                        .buttonStyle(.plain)

                        VStack(alignment: .leading) {

                            Text(task.title)

                            Text(task.assignedUser)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        Circle()
                            .fill(priorityColor(task.priority))
                            .frame(width: 8, height: 8)
                    }
                }
            }
        }
    }
}
