//
//  CompletionRecord.swift
//  CleaningADHD
//
//  Created by Rachel Culligan on 6/16/26.
//

import Foundation
import SwiftData

@Model
class CompletionRecord {

    var id: UUID
    var taskID: UUID
    var taskName: String
    var completedBy: String
    var completedDate: Date

    init(
        taskID: UUID,
        taskName: String,
        completedBy: String
    ) {

        self.id = UUID()
        self.taskID = taskID
        self.taskName = taskName
        self.completedBy = completedBy
        self.completedDate = Date()
    }
}
