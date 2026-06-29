//
//  CalendarView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/17/26.
//

import SwiftUI
import SwiftData

struct CalendarView: View {

    @Query(sort: \CleaningTask.dueDate)
    private var tasks: [CleaningTask]

    var body: some View {

        NavigationStack {

            List {

                Section("Today") {

                    ForEach(tasks.filter {
                        Calendar.current.isDateInToday(
                            $0.dueDate
                        )
                    }) { task in

                        Text(task.title)
                    }
                }

                Section("Upcoming") {

                    ForEach(tasks.filter {
                        $0.dueDate > Date()
                    }) { task in

                        VStack(alignment: .leading) {

                            Text(task.title)

                            Text(
                                task.dueDate,
                                style: .date
                            )
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Calendar")
        }
    }
}

#Preview {
    CalendarView()
}
