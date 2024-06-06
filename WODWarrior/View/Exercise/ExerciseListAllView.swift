//
//  ExerciseListAllView.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import SwiftUI
import SwiftData

struct ExerciseListAllView: View {
    @Query private var exercises: [Exercise]
    @Environment(\.modelContext) private var context
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            List {
                Section(header: Text("Exercises")) {
                    ForEach(exercises) { exercise in
                        HStack{
                            Text(exercise.name)
                        }
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
                
            }
        }
    }
}

#Preview {
    ExerciseListAllView()
}
