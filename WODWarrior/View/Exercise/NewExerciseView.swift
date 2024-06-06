//
//  NewExerciseView.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import SwiftUI
import SwiftData
import UIKit
import AVKit
import PhotosUI

struct NewExerciseView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State var exercise = Exercise()
    @Query private var exercises: [Exercise]
    
    @StateObject var videoPicker = VideoPicker()
    
    var body: some View {
        NavigationStack {
                  Form {
                      Section(header: Text("Exercises")) {
                          TextField("Exercise", text: $exercise.name)
                          TextField("About", text: $exercise.about)
                          Button("Create") {
                              withAnimation {
                                  if let videoURL = videoPicker.getVideoURL() {
                                                                  let newExercise = Exercise(name: exercise.name, about: exercise.about, video: videoURL)
                                                                  context.insert(newExercise)
                                                                  try? context.save()
                                                                  
                                                                  // Очистити поля після збереження
                                                                  exercise.name = ""
                                                                  exercise.about = ""
                                                                  exercise.video = nil
                                                              }
                              }
                              dismiss()
                          }
                          .disabled(exercise.name.isEmpty)
                      }
                      Section(header: Text("Adding video")) {
                                          PhotosPicker(selection: $videoPicker.videoSelection, matching: .videos) {
                                              Label("Add Video", systemImage: "video")
                                          }
                                          
                                          switch videoPicker.videoImportState {
                                          case .empty:
                                              Image(systemName: "video.fill")
                                                  .font(.system(size: 40))
                                                  .foregroundColor(.white)
                                          case .loading(_):
                                              ProgressView()
                                          case .success(let player):
                                              VideoPlayer(player: player)
                                          case .failure(_):
                                              Image(systemName: "exclamationmark.triangle.fill")
                                                  .font(.system(size: 40))
                                                  .foregroundColor(.white)
                                          }
                                      }
                      
                      /**Section(header: Text("Adding video")) {
                          PhotosPicker(selection: $videoPicker, matching: .videos) {
                              Label("Add Video", systemImage:"video")
                          }
                          
                          switch videoPicker.videoImportState {
                          case .empty:
                              Image(systemName: "video.fill")
                                  .font(.system(size: 40))
                                  .foregroundColor(.white)
                          case .loading(let progress):
                              ProgressView()
                          case .success(let video):
                              VideoPlayer(player: video)
                          case .failure(let error):
                              Image(systemName: "exclamationmark.triangle.fill")
                                  .font(.system(size: 40))
                                  .foregroundColor(.white)
                          }
                      }*/
                  }
                  .navigationTitle("New Exercise")
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
    NewExerciseView()
}
