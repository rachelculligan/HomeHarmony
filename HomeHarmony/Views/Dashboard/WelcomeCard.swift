//
//  WelcomeCard.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/29/26.
//

import SwiftUI

struct WelcomeCard: View {

    let householdName: String
    let userName: String
    let tasksRemaining: Int

    var body: some View {

        PrimaryCard {

            VStack(alignment: .leading, spacing: 10) {

                Text("\(greeting), \(userName)")
                    .font(.largeTitle.bold())

                Text(message)
                    .font(.headline)
                    .foregroundStyle(.secondary)

                Label(
                    householdName,
                    systemImage: "house.fill"
                )
                .foregroundStyle(.secondary)

                Divider()

                Label(
                    "\(tasksRemaining) tasks remaining today",
                    systemImage: "checklist"
                )
                .font(.headline)
            }
        }
    }
    
    private var message: String {
        
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
            
        case 5..<12:
            return "Let's make today productive."
            
        case 12..<17:
            return "You're making great progress."
            
        default:
            return "Finish strong tonight!"
        }
    }
    private var greeting: String {
        
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
            
        case 5..<12:
            return "☀️ Good Morning"
            
        case 12..<17:
            return "🌤 Good Afternoon"
            
        default:
            return "🌙 Good Evening"
        }
    }
}
