//
//  ExerciseView.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import SwiftUI
import SwiftData

struct ExerciseView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Exercise.name) private var exercises: [Exercise]
    
    @State var trainingSection = TrainingSection()
    
    var body: some View {
        NavigationStack {
            List {
                Section("Exercises") {
                    ForEach(exercises) { exercise in
                        Text(exercise.name)
                            .swipeActions {
                                Button(role: .destructive) {
                                    withAnimation {
                                        context.delete(exercise)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                            }
                    }
                }
                NavigationLink(destination: NewExerciseView()) {
                    Text("Add exercise")
                }
            }
        }
    }
}

#Preview {
    let preview = Preview(Exercise.self)
    preview.addExamples(Exercise.sampleExercises)
    return ExerciseView()
        .modelContainer(preview.container)
}
