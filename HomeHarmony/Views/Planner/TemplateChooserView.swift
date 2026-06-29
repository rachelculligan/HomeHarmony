//
//  TemplateChooserView.swift
//  HomeHarmony
//
//  Created by Rachel Culligan on 6/17/26.
//

import SwiftUI

struct TemplateChooserView: View {

    let onSelect: (CleaningTemplate) -> Void

    var body: some View {

        NavigationStack {

            List {

                NavigationLink {

                    TemplateDetailView(
                        template:
                            CleaningTemplates.adhdStarter
                    ) { template in

                        onSelect(template)
                    }

                } label: {

                    VStack(alignment: .leading) {

                        Text("ADHD Starter Plan")
                            .font(.headline)

                        Text(
                            "Quick wins for overwhelmed days"
                        )
                        .font(.caption)
                    }
                }

                NavigationLink {

                    TemplateDetailView(
                        template:
                            CleaningTemplates.weeklyReset
                    ) { template in

                        onSelect(template)
                    }

                } label: {

                    VStack(alignment: .leading) {

                        Text("Weekly House Reset")
                            .font(.headline)

                        Text(
                            "Core weekly cleaning tasks"
                        )
                        .font(.caption)
                    }
                }
            }
            .navigationTitle("Templates")
        }
    }
}

#Preview {

    TemplateChooserView { _ in }
}
