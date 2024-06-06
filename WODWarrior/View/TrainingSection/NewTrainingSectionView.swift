//
//  NewTrainingSectionView.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import SwiftUI
import SwiftData
import PhotosUI

struct NewTrainingSectionView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State var trainingSection = TrainingSection()
    @Query private var sections: [TrainingSection]
    
    var body: some View {
        NavigationStack {
                  Form {
                      Section(header: Text("Training Section Details")) {
                          TextField("Training Section", text: $trainingSection.name)
                          Button("Create") {
                              withAnimation {
                                  let newSection = TrainingSection(name: trainingSection.name)
                                  context.insert(newSection)
                                  trainingSection.name = ""
                                  trainingSection.exercises = []
                              }
                              dismiss()
                          }
                          .disabled(trainingSection.name.isEmpty)
                      }
                  }
                  .navigationTitle("New Section")
                  .navigationBarTitleDisplayMode(.inline)
                  .toolbar {
                      ToolbarItem(placement: .topBarLeading) {
                          Button("Cancel") {
                              dismiss()
                          }
                      }
                  }
              }
          }
      }


#Preview {
    NewTrainingSectionView()
}
