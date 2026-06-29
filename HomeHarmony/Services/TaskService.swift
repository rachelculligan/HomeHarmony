//
//  TaskService.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/25/26.
//

import Foundation
import SwiftData

struct TaskService {

    static func toggleComplete(
        task: CleaningTask,
        context: ModelContext
    ) -> Bool {
        
        if task.completed {

            task.completed = false
            task.completedDate = nil

            try? context.save()
            return false
            
        } else {

            task.completedDate = Date()
            task.todayFocus = false

            switch task.frequency {

            case "Daily":

                task.dueDate = Calendar.current.date(
                    byAdding: .day,
                    value: 1,
                    to: task.dueDate
                ) ?? task.dueDate

                task.completed = false

            case "Weekly":

                task.dueDate = Calendar.current.date(
                    byAdding: .day,
                    value: 7,
                    to: task.dueDate
                ) ?? task.dueDate

                task.completed = false

            case "Monthly":

                task.dueDate = Calendar.current.date(
                    byAdding: .month,
                    value: 1,
                    to: task.dueDate
                ) ?? task.dueDate

                task.completed = false

            default:

                task.completed = true
            }
        }

        try? context.save()
        return true
    }
}
