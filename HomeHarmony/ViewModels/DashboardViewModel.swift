//
//  DashboardViewModel.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/25/26.
//

import Foundation
import SwiftData
import Observation

@Observable
class DashboardViewModel {

    func filteredTasks(
        tasks: [CleaningTask],
        currentUserName: String
    ) -> [CleaningTask] {

        if currentUserName == "All" {
            return tasks
        }

        return tasks.filter {
            $0.assignedUser == currentUserName
        }
    }

    func overdueTasks(
        tasks: [CleaningTask],
        currentUserName: String
    ) -> [CleaningTask] {

        let filtered = filteredTasks(
            tasks: tasks,
            currentUserName: currentUserName
        )

        return filtered.filter {

            !$0.completed &&
            !Calendar.current.isDateInToday($0.dueDate) &&
            $0.dueDate < Date()
        }
    }
}
