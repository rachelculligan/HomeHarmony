//
//  WeekHeader.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 7/2/26.
//


import SwiftUI

struct WeekHeader: View {

    @Binding var weekStart: Date

    var body: some View {

        HStack {

            Button {

                previousWeek()

            } label: {

                Image(systemName: "chevron.left")
            }

            Spacer()

            Text(weekRange)
                .font(.headline)

            Spacer()

            Button {

                nextWeek()

            } label: {

                Image(systemName: "chevron.right")
            }
        }
        .padding(.horizontal)
    }

    private var weekRange: String {

        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"

        let end = Calendar.current.date(
            byAdding: .day,
            value: 6,
            to: weekStart
        )!

        return "\(formatter.string(from: weekStart)) – \(formatter.string(from: end))"
    }

    private func previousWeek() {

        weekStart = Calendar.current.date(
            byAdding: .day,
            value: -7,
            to: weekStart
        )!
    }

    private func nextWeek() {

        weekStart = Calendar.current.date(
            byAdding: .day,
            value: 7,
            to: weekStart
        )!
    }
}