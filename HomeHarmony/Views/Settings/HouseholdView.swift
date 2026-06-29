//
//  HouseholdView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/17/26.
//

import SwiftUI
import SwiftData

struct HouseholdView: View {

    @Environment(\.modelContext)
    private var context

    @Query
    private var members: [HouseholdMember]
    
    @Query
    private var tasks: [CleaningTask]
    
    @State private var newMember = ""
    
    var householdStats: [(String, Int)] {

        members.map { member in

            let count = tasks.filter {
                $0.assignedUser == member.name &&
                $0.completed
            }.count

            return (member.name, count)
        }
    }
    
    var body: some View {

        NavigationStack {

            List {
                Section("🏆 Scoreboard") {

                    ForEach(
                        householdStats,
                        id: \.0
                    ) { person, count in

                        HStack {

                            Text(person)

                            Spacer()

                            Text("\(count)")
                                .bold()
                        }
                    }
                }
                
                Section("Members") {

                    ForEach(members) { member in

                        Text(member.name)
                    }
                    .onDelete { indexSet in

                        for index in indexSet {

                            context.delete(
                                members[index]
                            )
                        }

                        try? context.save()
                    }
                }
                Text("Members Count: \(members.count)")
                Section("Add Member") {

                    HStack {

                        TextField(
                            "Enter name",
                            text: $newMember
                        )
                        .textFieldStyle(.roundedBorder)

                        Button("Add") {

                            guard !newMember.isEmpty else {
                                return
                            }

                            let member = HouseholdMember(
                                name: newMember
                            )

                            context.insert(member)

                            try? context.save()

                            newMember = ""
                        }
                    }
                }
            }
            .navigationTitle("Household")
        }
    }
}

#Preview {
    HouseholdView()
}
