//
//  TemplateDetailView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/17/26.
//

import SwiftUI

struct TemplateDetailView: View {

    let template: CleaningTemplate
    let onLoad: (CleaningTemplate) -> Void

    @Environment(\.dismiss)
    private var dismiss

    var totalMinutes: Int {

        template.tasks.reduce(0) {
            $0 + $1.minutes
        }
    }

    var body: some View {

        List {

            Section {

                VStack(spacing: 8) {

                    Text(template.name)
                        .font(.title2)
                        .bold()

                    Text(
                        "\(template.tasks.count) Tasks • \(totalMinutes) Minutes"
                    )
                    .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
            }

            Section("Tasks") {

                ForEach(
                    template.tasks,
                    id: \.title
                ) { task in

                    HStack {

                        VStack(
                            alignment: .leading
                        ) {

                            Text(task.title)

                            Text(task.room)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        Text("\(task.minutes)m")
                            .foregroundStyle(.secondary)
                    }
                }
            }

            Section {

                Button {

                    onLoad(template)

                    dismiss()

                } label: {

                    Text("Load Template")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .navigationTitle("Template")
    }
}

#Preview {

    TemplateDetailView(
        template:
            CleaningTemplates.adhdStarter
    ) { _ in }
}
