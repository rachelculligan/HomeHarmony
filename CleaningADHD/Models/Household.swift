//
//  Household.swift
//  CleaningADHD
//
//  Created by Rachel Culligan on 6/16/26.
//

import Foundation
import SwiftData

@Model
class Household {

    var id: UUID
    var name: String
    var createdDate: Date

    init(name: String) {
        self.id = UUID()
        self.name = name
        self.createdDate = Date()
    }
}
