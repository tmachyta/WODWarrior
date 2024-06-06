//
//  CardStackView.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import SwiftUI
import SwiftData

struct CardStackView: View {
    @StateObject var viewModel = CardViewModel(service: CardService())
    @Environment(\.managedObjectContext) private var context
    @Query private var programs: [TrainingProgram]
    @State private var selectedDate = Date()
    @State private var isShowingDatePicker = false
    
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        return formatter
    }()
    
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
            VStack(spacing: 16) {
                ZStack {
                    if filteredPrograms.isEmpty {
                        VStack {
                            ProgressView()
                                .progressViewStyle(ColoredProgressViewStyle(color: .white))
                            Text("Reloading programs")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                    } else if isRestDay(selectedDate) {
                        Text("Rest Day")
                    } else {
                        ForEach(filteredPrograms) { program in
                            CardView(viewModel: viewModel, model: CardModel(trainingProgram: program))
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray]), startPoint: .top, endPoint: .bottom))
                        .edgesIgnoringSafeArea(.all)
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
                            Text(dateFormatter.string(from: selectedDate))
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        Image("applogo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 55)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.horizontal)
                    .padding(.top, -1)
                }
            }
            .sheet(isPresented: $isShowingDatePicker) {
                DatePickerView(selectedDate: $selectedDate)
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

extension CardStackView {
    func isRestDay(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: date)
        return dayOfWeek == 1
        
    }
}

#Preview {
    CardStackView()
}
