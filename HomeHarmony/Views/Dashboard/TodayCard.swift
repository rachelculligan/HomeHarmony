//
//  TodayCard.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/29/26.
//

import SwiftUI

struct TodayCard: View {

    let tasks: [CleaningTask]
    let priorityColor: (Int) -> Color
    let onComplete: (CleaningTask) -> Void

    var body: some View {

        PrimaryCard {

            SectionHeader(
                title: "Today's Mission",
                icon: "checklist"
            )
            Text("\(tasks.count) Tasks Remaining")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            if tasks.isEmpty {

                VStack(spacing: 12) {

                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 40))
                        .foregroundStyle(.green)

                    Text("🎉 Everything is done!")
                        .font(.title3.bold())

                    Text("Time to relax. You earned it!")
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)

            } else {

                ForEach(tasks.prefix(5)) { task in

                    HStack(spacing: 16) {

                        Button {

                            onComplete(task)

                        } label: {

                            Image(systemName:
                                task.completed
                                ? "checkmark.circle.fill"
                                : "circle"
                            )
                            .font(.title2)
                            .foregroundStyle(.green)
                        }
                        .buttonStyle(.plain)

                        VStack(alignment: .leading, spacing: 4) {

                            Text(task.title)
                                .font(.headline)

                            HStack {

                                Label(
                                    task.room,
                                    systemImage: "house.fill"
                                )

                                Label(
                                    "\(task.estimatedMinutes)m",
                                    systemImage: "clock"
                                )
                            }
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        }

                        Spacer()

                        RoundedRectangle(cornerRadius: 4)
                            .fill(priorityColor(task.priority))
                            .frame(width: 6, height: 40)
                    }
                }
            }
        }
    }
}
