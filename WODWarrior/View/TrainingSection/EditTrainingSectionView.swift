//
//  EditTrainingSectionView.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import SwiftUI
import SwiftData

struct EditTrainingSectionView: View {
    @Environment(\.dismiss) private var dismiss
        @Environment(\.modelContext) private var context
        @State var trainingSection = TrainingSection()
        @State private var selectedExercise: Exercise?
        @Query private var exercises: [Exercise]

        var body: some View {
            VStack {
                Form {
                    Section(header: Text("Details").foregroundStyle(.secondary)) {
                        TextField("Name", text: $trainingSection.name)
                    }
                    
                    Section(header: Text("Add Exercise").foregroundStyle(.secondary)) {
                        Picker("Select Exercise", selection: $selectedExercise) {
                            ForEach(exercises) { exercise in
                                Text(exercise.name)
                                    .tag(exercise as Exercise?)
                            }
                            Text("None")
                                .tag(nil as Exercise?)
                        }
                        .pickerStyle(.menu)
                        
                        Button("Add Exercise to Section") {
                            addSectionToProgram()
                        }
                        .disabled(selectedExercise == nil)
                    }
                }
            }
            .navigationTitle(trainingSection.name.isEmpty ? "Edit Section" : trainingSection.name)
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
                trainingSection.name = trainingSection.name
            }
        }

        private func addSectionToProgram() {
            guard let selectedExercise = selectedExercise else { return }
            if trainingSection.exercises == nil {
                trainingSection.exercises = []
            }
            trainingSection.exercises?.append(selectedExercise)
            selectedExercise.trainingSection = trainingSection
            context.insert(selectedExercise)
            self.selectedExercise = nil
        }

        private func updateProgram() {
            trainingSection.name = trainingSection.name
        }

        var changed: Bool {
            trainingSection.name != trainingSection.name
        }
    }

    #Preview {
        let preview = Preview(TrainingSection.self)
        return NavigationStack {
            EditTrainingSectionView(trainingSection: TrainingSection.sampleSections[0])
                .modelContainer(preview.container)
        }
    }
