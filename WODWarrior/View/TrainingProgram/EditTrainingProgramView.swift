//
//  EditTrainingProgramView.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import SwiftUI
import SwiftData

struct EditTrainingProgramView: View {
    @Environment(\.dismiss) private var dismiss
        @Environment(\.modelContext) private var context
        @State var trainingProgram = TrainingProgram()
        @State private var selectedSection: TrainingSection?
        @Query private var sections: [TrainingSection]

        var body: some View {
            VStack {
                Form {
                    Section(header: Text("Details").foregroundStyle(.secondary)) {
                        TextField("Name", text: $trainingProgram.name)
                        TextField("About", text: $trainingProgram.about)
                    }
                    
                    Section(header: Text("Add Section").foregroundStyle(.secondary)) {
                        Picker("Select Section", selection: $selectedSection) {
                            ForEach(sections) { section in
                                Text(section.name)
                                    .tag(section as TrainingSection?)
                            }
                            Text("None")
                                .tag(nil as TrainingSection?)
                        }
                        .pickerStyle(.menu)
                        
                        Button("Add Section to Program") {
                            addSectionToProgram()
                        }
                        .disabled(selectedSection == nil)
                    }
                }
            }
            .navigationTitle(trainingProgram.name.isEmpty ? "Edit Program" : trainingProgram.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if changed {
                        Button("Update") {
                            updateProgram()
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .onAppear {
                trainingProgram.name = trainingProgram.name
                trainingProgram.about = trainingProgram.about
            }
        }

        private func addSectionToProgram() {
            guard let selectedSection = selectedSection else { return }
            if trainingProgram.sections == nil {
                trainingProgram.sections = []
            }
            trainingProgram.sections?.append(selectedSection)
            selectedSection.trainingProgram = trainingProgram
            context.insert(selectedSection)
            self.selectedSection = nil
        }

        private func updateProgram() {
            trainingProgram.name = trainingProgram.name
            trainingProgram.about = trainingProgram.about
        }

        var changed: Bool {
            trainingProgram.name != trainingProgram.name || trainingProgram.about != trainingProgram.about
        }
    }

#Preview {
    let preview = Preview(TrainingProgram.self)
    return NavigationStack {
        EditTrainingProgramView(trainingProgram: TrainingProgram.samplePrograms[0])
            .modelContainer(preview.container)
    }
}
