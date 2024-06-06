//
//  AdminPageView.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import SwiftUI

struct AdminPageView: View {
    @State private var selectedDate = Date()
    @State private var isShowingDatePicker = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Welcome Section
                    Text("Welcome, User!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)

                    // Image Carousel
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(0..<5) { index in
                                Image("sampleImage\(index)")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 300, height: 200)
                                    .clipped()
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)
                    }

                    // Quick Access Icons
                    HStack(spacing: 20) {
                        NavigationLink(destination: TrainingProgramView()) {
                            VStack {
                                Image(systemName: "flame.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding()
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                Text("Training")
                                    .font(.headline)
                            }
                        }

                        NavigationLink(destination: NewTrainingProgramView()) {
                            VStack {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                Text("New Program")
                                    .font(.headline)
                            }
                        }

                        NavigationLink(destination: NewExerciseView()) {
                            VStack {
                                Image(systemName: "figure.walk")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                Text("Exercise")
                                    .font(.headline)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        NavigationLink(destination: ExerciseView()) {
                            VStack {
                                Image(systemName: "rectangle")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                Text("Exercises")
                                    .font(.headline)
                            }
                        }
                        
                        
                        NavigationLink(destination: TrainingSectionView()) {
                            VStack {
                                Image(systemName: "rectangle")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                Text("Sections")
                                    .font(.headline)
                            }
                        }
                    }
                    
                    // Additional content here
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image("applogo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 55)
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                        Spacer()

                        Button {
                            isShowingDatePicker = true
                        } label: {
                            Text("\(selectedDate, formatter: dateFormatter)")
                                .font(.headline)
                        }

                        Spacer()

                        Image("applogo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.horizontal)
                    .padding(.top, -1)
                }
            }
            .sheet(isPresented: $isShowingDatePicker) {
                DatePickerSheet(selectedDate: $selectedDate)
                    .presentationDetents([.medium])
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
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMMM"
    return formatter
}()

#Preview {
    AdminPageView()
}
