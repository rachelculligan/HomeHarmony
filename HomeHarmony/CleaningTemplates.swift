//
//  CleaningTemplates.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/17/26.
//
import Foundation

struct CleaningTemplate {

    let name: String
    let tasks: [(title: String, room: String, minutes: Int)]
}

struct CleaningTemplates {

    static let weeklyReset = CleaningTemplate(

        name: "Weekly House Reset",

        tasks: [

            ("Empty Dishwasher", "Kitchen", 5),
            ("Wipe Counters", "Kitchen", 5),
            ("Clean Toilet", "Bathroom", 10),
            ("Vacuum Living Room", "Living Room", 15),
            ("Laundry", "Laundry Room", 20),
            ("Make Bed", "Bedroom", 5)
        ]
    )

    static let adhdStarter = CleaningTemplate(

        name: "ADHD Starter Plan",

        tasks: [

            ("Take Out Trash", "Kitchen", 5),
            ("Clear Kitchen Sink", "Kitchen", 5),
            ("Wipe Bathroom Sink", "Bathroom", 3),
            ("Pick Up Floor Items", "Living Room", 5),
            ("Start Laundry", "Laundry Room", 3)
        ]
    )
}
