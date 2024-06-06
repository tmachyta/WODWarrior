//
//  TrainingSectionView.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import SwiftUI
import SwiftData

struct TrainingSectionView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \TrainingSection.name) private var sections: [TrainingSection]
    
    @State var trainingSection = TrainingSection()

    var body: some View {
        NavigationStack {
            List {
                Section("Training Sections") {
                    ForEach(sections) { section in
                        NavigationLink(destination: EditTrainingSectionView(trainingSection: section)) {
                            Text(section.name)
                        }
                            .swipeActions {
                                Button(role: .destructive) {
                                    withAnimation {
                                        context.delete(section)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                            }
                        
                        ForEach(section.exercises ?? [], id: \.self) { exercise in
                            NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                                Text(exercise.name)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                NavigationLink(destination: NewTrainingSectionView()) {
                    Text("Add section")
                }
            }
        }
    }
}

#Preview {
    let preview = Preview(TrainingSection.self)
    preview.addExamples(TrainingSection.sampleSections)
    return TrainingSectionView()
        .modelContainer(preview.container)
}

