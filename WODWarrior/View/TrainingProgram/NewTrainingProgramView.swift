//
//  NewTrainingProgramView.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import SwiftUI
import SwiftData
import PhotosUI

struct NewTrainingProgramView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State var trainingProgram = TrainingProgram()
    @Query private var trainingPrograms: [TrainingProgram]
    @State var selectedPhoto: PhotosPickerItem?
    @State var selectedDate = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Training Program")) {
                    TextField("Training Program", text: $trainingProgram.name)
                    TextField("About", text: $trainingProgram.about)
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    Button("Add Program") {
                        withAnimation {
                            trainingProgram.date = selectedDate
                            
                            // Ensure trainingProgram.images is unwrapped safely
                            let images = trainingProgram.images ?? []
                            
                            let newProgram = TrainingProgram(name: trainingProgram.name, about: trainingProgram.about, images: images, date: trainingProgram.date)
                            context.insert(newProgram)
                            
                            trainingProgram.name = ""
                            trainingProgram.about = ""
                            trainingProgram.images = nil
                        }
                        
                        dismiss()
                    }
                    .disabled(trainingProgram.name.isEmpty)
                }
                
                Section(header: Text("Adding Photos")) {
                    
                    ForEach(trainingProgram.images ?? [], id: \.self) { imageData in
                        if let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 300)
                        }
                    }
                    
                    PhotosPicker(selection: $selectedPhoto, matching: .images, photoLibrary: .shared()) {
                        Label("Add Image", systemImage:"photo")
                    }
                    
                    
                    if  trainingProgram.images != nil {
                        Button(role: .destructive) {
                            withAnimation {
                                selectedPhoto = nil
                                trainingProgram.images = nil
                            }
                        } label: {
                            Label("Remove Image", systemImage: "xmark")
                                .foregroundStyle(.red)
                        }
                    }
                    
                }
            }
            .navigationTitle("New Program")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .task(id: selectedPhoto) {
                if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                    if trainingProgram.images == nil {
                        trainingProgram.images = [] // Initialize if nil
                    }
                    trainingProgram.images?.append(data) // Append the new image data
                }
            }
        }
    }
}


#Preview {
    NewTrainingProgramView()
}
