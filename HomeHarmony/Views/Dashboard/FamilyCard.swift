//
//  FamilyCard.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/29/26.
//

import SwiftUI

struct FamilyCard: View {
    
    let members: [HouseholdMember]
    
    private var sortedMembers: [HouseholdMember] {
        members.sorted { $0.points > $1.points }
    }
    
    private var totalPoints: Int {
        members.reduce(0) { $0 + $1.points }
    }
    
    var body: some View {
        
        PrimaryCard {
            
            SectionHeader(
                title: "Family",
                icon: "person.3.fill"
            )
            
            VStack(spacing: 10) {
                
                ForEach(Array(sortedMembers.enumerated()), id: \.element.id) { index, member in
                    
                    NavigationLink {
                        
                        ProfileView(member: member)
                        
                    } label: {
                        
                        HStack(spacing: 14) {
                            
                            AvatarView(member: member)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                
                                HStack {
                                    
                                    Text(rank(for: index))
                                    
                                    Text(member.name)
                                        .font(.headline)
                                }
                                
                                Text("Level \(member.level)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                            
                            HStack(spacing: 4) {
                                
                                Text("\(member.points)")
                                    .font(.title3.bold())
                                
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                            }
                            
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundStyle(.tertiary)
                        }
                        .padding(.vertical, 6)
                    }
                    .buttonStyle(.plain)
                }
                
                Divider()
                
                HStack {
                    
                    Label(
                        "Family Total",
                        systemImage: "star.circle.fill"
                    )
                    
                    Spacer()
                    
                    Text("\(totalPoints)")
                        .font(.title2.bold())
                        .foregroundStyle(.orange)
                }
            }
        }
    }
    
    private func rank(for index: Int) -> String {
        
        switch index {
            
        case 0:
            return "👑"
            
        case 1:
            return "🥈"
            
        case 2:
            return "🥉"
            
        default:
            return "⭐️"
        }
    }
    
}
#Preview {

    FamilyCard(
        members: [
            HouseholdMember(
                name: "Rachel",
                avatar: "person.fill",
                color: "blue",
                points: 420
            ),
            HouseholdMember(
                name: "David",
                avatar: "person.fill",
                color: "green",
                points: 310
            ),
            HouseholdMember(
                name: "Nora",
                avatar: "person.fill",
                color: "purple",
                points: 220
            )
        ]
    )
}
