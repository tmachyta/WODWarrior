//
//  ExerciseDetailView.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import SwiftUI
import AVKit

struct ExerciseDetailView: View {
    @State var exercise = Exercise()
    @StateObject private var videoPicker = VideoPicker()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 16) {
                Text(exercise.about)
                    .font(.headline)
                    .padding(.bottom, 8)
                
                Divider()
                
                if let videoURL = exercise.video ?? videoPicker.getVideoURL() {
                                VideoPlayer(player: AVPlayer(url: videoURL))
                                    .frame(height: 200)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                    .padding(.bottom, 16)
                            }
                
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 5)
        .navigationBarTitle(exercise.name)
        }
    }
}


#Preview {
    let preview = Preview(Exercise.self)
    preview.addExamples(Exercise.sampleExercises)
    return ExerciseDetailView(exercise: Exercise.sampleExercises[0])
        .modelContainer(preview.container)
}
