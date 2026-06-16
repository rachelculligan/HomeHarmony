//import SwiftUI
//  CleaningADHD.swift
//  CleaningADHD
//
//  Created by Rachel Culligan on 6/16/26.
//
import Foundation
import SwiftData

@Model
class CleaningTask {

    var id: UUID
    var title: String
    var room: String
    var frequency: String
    var assignedUser: String
    var dueDate: Date
    var completed: Bool
    var completedDate: Date?
    var estimatedMinutes: Int
    var priority: Int
    var isQuickWin: Bool
   init(
        title: String,
        room: String,
        frequency: String,
        assignedUser: String,
        dueDate: Date,
        estimatedMinutes: Int = 5,
        priority: Int = 1,
        isQuickWin: Bool = false
    ) {
        self.id = UUID()
        self.title = title
        self.room = room
        self.frequency = frequency
        self.assignedUser = assignedUser
        self.dueDate = dueDate
        self.completed = false
        self.completedDate = nil
        self.estimatedMinutes = estimatedMinutes
        self.priority = priority
        self.isQuickWin = isQuickWin    }
}
