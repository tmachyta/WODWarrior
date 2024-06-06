//
//  TrainingSectionDetailsView.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import SwiftUI

struct TrainingSectionDetailsView: View {
    let section: TrainingSection
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                if let exercises = section.exercises {
                    List {
                        ForEach(exercises, id: \.self) { exercise in
                            NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                                HStack {
                                    Image(systemName: "figure.martial.arts")
                                        .foregroundColor(.black)
                                    Text(exercise.name)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.clear)
                } else {
                    Text("No exercises available")
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
    }
}

#Preview {
    TrainingSectionDetailsView(section: TrainingSection.sampleSections[1])
}
