//
//  SettingsView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/23/26.
//

import SwiftUI
import SwiftData

struct SettingsView: View {

    @Environment(\.modelContext)
    private var context

    @Query
    private var households: [Household]
    
    @State private var householdName = ""
    var household: Household? {
        households.first
    }

    var body: some View {

        NavigationStack {

            Form {


                if let household = households.first {

                    Section("🏠 Household") {

                        TextField(
                            "Household Name",
                            text: Binding(
                                get: { household.name },
                                set: { household.name = $0 }
                            )
                        )

                        Text("Invite Code: \(household.inviteCode)")
                    }

                } else {

                    Section("🏠 Create Household") {

                        TextField(
                            "Household Name",
                            text: $householdName
                        )

                        Button("Create Household") {

                            guard !householdName.isEmpty else {
                                return
                            }

                            let home = Household(
                                name: householdName,
                                inviteCode: generateInviteCode()
                            )

                            context.insert(home)

                            try? context.save()

                            householdName = ""
                        }
                    }
                    
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }

    func generateInviteCode() -> String {

        let letters = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789"

        return String(
            (0..<6).map { _ in
                letters.randomElement()!
            }
        )
    }



#Preview {
    SettingsView()
}
