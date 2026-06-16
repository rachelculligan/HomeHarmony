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
    var completedBy: String
    var completedDate: Date

    init(
        taskID: UUID,
        completedBy: String
    ) {
        self.id = UUID()
        self.taskID = taskID
        self.completedBy = completedBy
        self.completedDate = Date()
    }
}
