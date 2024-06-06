//
//  TrainingProgramView.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import SwiftUI
import SwiftData

enum SortOrder: String, Identifiable, CaseIterable {
    case name
    
    var id: Self {
        self
    }
}

struct TrainingProgramView: View {
    @Environment(\.modelContext) private var context
    @Query private var programs: [TrainingProgram]
    
    @State private var selectedDate = Date()
    @State private var isShowingDatePicker = false
    
    var filteredPrograms: [TrainingProgram] {
        programs.filter { program in
            if let programDate = program.date {
                return Calendar.current.isDate(programDate, inSameDayAs: selectedDate)
            }
            return false
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Training Programs")) {
                    if isRestDay(selectedDate) {
                        Text("Rest Day")
                    } else {
                        ForEach(filteredPrograms) { program in
                            NavigationLink(destination: EditTrainingProgramView(trainingProgram: program)) {
                                HStack {
                                    Text(program.name)
                                    if let images = program.images {
                                        ForEach(images, id: \.self) { imageData in
                                            if let uiImage = UIImage(data: imageData) {
                                                Image(uiImage: uiImage)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(maxWidth: 50, maxHeight: 50)
                                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                            }
                                        }
                                    }
                                }
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    withAnimation {
                                        context.delete(program)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                            }
                            
                            ForEach(program.sections ?? [], id: \.self) { section in
                                NavigationLink(destination: TrainingSectionView()) {
                                    Text(section.name)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: NewTrainingProgramView()) {
                        Text("Add Program")
                    }
                }
                
                Section {
                    NavigationLink(destination: NewTrainingSectionView()) {
                        Text("Add Section")
                    }
                }
                
                Section {
                    NavigationLink(destination: NewExerciseView()) {
                        Text("Add Exercise")
                    }
                }
            }
            .toolbar {
                Button {
                    isShowingDatePicker = true
                } label: {
                    Image(systemName: "calendar")
                        .imageScale(.large)
                }
            }
            .sheet(isPresented: $isShowingDatePicker) {
                DatePickerView(selectedDate: $selectedDate)
                    .presentationDetents([.medium])
            }
        }
    }
            
}

    struct DatePickerSheet: View {
        @Binding var selectedDate: Date

        var body: some View {
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .padding()
        }
    }


extension TrainingProgramView {
    func isRestDay(_ date: Date) -> Bool {
            let calendar = Calendar.current
            let dayOfWeek = calendar.component(.weekday, from: date)
            return dayOfWeek == 1
    }
}

#Preview {
    let preview = Preview(TrainingProgram.self)
    preview.addExamples(TrainingProgram.samplePrograms)
    return TrainingProgramView()
        .modelContainer(preview.container)
}
