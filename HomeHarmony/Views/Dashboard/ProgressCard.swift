//
//  ProgressCard.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/29/26.
//

import SwiftUI

struct ProgressCard: View {

    let streak: Int
    let progress: Double
    let completed: Int
    let total: Int
    
    private var progressColor: Color {
        switch progress {
        case 0.8...:
            return .green
        case 0.4..<0.8:
            return .orange
        default:
            return .red
        }
    }
    
    var body: some View {

        PrimaryCard {

            SectionHeader(
                title: "Today's Progress",
                icon: "flame.fill"
            )

            VStack(spacing: 20) {

                ZStack {

                    Circle()
                        .stroke(.gray.opacity(0.2), lineWidth: 12)

                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(
                            progressColor,
                            style: StrokeStyle(
                                lineWidth: 12,
                                lineCap: .round
                            )
                        )
                        .rotationEffect(.degrees(-90))
                        .animation(
                            .easeInOut(duration: 0.8),
                            value: progress
                        )
                    VStack {

                        Text("\(Int(progress * 100))%")
                            .font(.title.bold())

                        Text("Complete")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(width: 140, height: 140)

                Label(
                    "\(completed) of \(total) Tasks Completed",
                    systemImage: "checkmark.circle.fill"
                )
                .font(.headline)
                .foregroundStyle(progressColor)

                HStack {

                    VStack {

                        Text("\(streak)")
                            .font(.title.bold())

                        Text("Day Streak")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    VStack {

                        Text("\(completed)")
                            .font(.title.bold())

                        Text("Completed Today")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}

#Preview {
    ProgressCard(
        streak: 18,
        progress: 0.72,
        completed: 12,
        total: 20
    )
}
