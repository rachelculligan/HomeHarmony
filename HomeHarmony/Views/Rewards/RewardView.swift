//
//  RewardView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/25/26.
//

import SwiftUI
import SwiftData

struct RewardsView: View {

    @Environment(\.modelContext)
    private var context

    @Query
    private var rewards: [Reward]

    @Query
    private var members: [HouseholdMember]

  
    
    var body: some View {

        NavigationStack {

            List {
                Section {

                    VStack(spacing: 12) {

                        Text("🏆 Your Points")
                            .font(.headline)

                        Text("⭐ \(currentPoints)")
                            .font(.largeTitle)
                            .bold()

                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)

                }
                ForEach(rewards) { reward in

                    HStack {

                        Image(systemName: reward.icon)
                            .font(.title2)
                            .foregroundStyle(.blue)

                        VStack(alignment: .leading, spacing: 6) {

                            Text(reward.title)
                                .font(.headline)

                            Text("\(reward.points) ⭐")
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        Button("Redeem") {

                            if let member = members.first {

                                _ = RewardService.redeem(
                                    reward: reward,
                                    member: member,
                                    context: context
                                )
                            }

                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(currentPoints < reward.points)
                    }
                    .padding(.vertical, 6)
                }
            }
                
            .navigationTitle("Rewards")
            .toolbar {

                ToolbarItem(placement: .topBarTrailing) {

                    Button {

                        loadDefaultRewards()

                    } label: {

                        Image(systemName: "sparkles")
                    }
                }
            }
        }
    }
    
    var currentPoints: Int {
        members.first?.points ?? 0
    }
    // 👇 MOVE THE FUNCTION HERE
    func loadDefaultRewards() {

        guard rewards.isEmpty else { return }

        context.insert(
            Reward(
                title: "30 Minutes Screen Time",
                points: 100,
                icon: "iphone"
            )
        )

        context.insert(
            Reward(
                title: "Ice Cream Night",
                points: 250,
                icon: "icecream"
            )
        )

        context.insert(
            Reward(
                title: "Movie Night",
                points: 500,
                icon: "movieclapper"
            )
        )

        context.insert(
            Reward(
                title: "Pick Dinner",
                points: 400,
                icon: "fork.knife"
            )
        )

        context.insert(
            Reward(
                title: "$5 Allowance",
                points: 500,
                icon: "dollarsign.circle"
            )
        )

        try? context.save()
    }

}

#Preview {
    RewardsView()
}
