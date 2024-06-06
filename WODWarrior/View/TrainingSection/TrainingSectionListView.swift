//
//  TrainingSectionListView.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import SwiftUI

struct TrainingSectionListView: View {
    @ObservedObject var viewModel: CardViewModel
    @State var trainingProgram: TrainingProgram
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                if let sections = trainingProgram.sections {
                    List {
                        ForEach(sections, id: \.self) { section in
                            NavigationLink(destination: TrainingSectionDetailsView(section: section)) {
                                HStack {
                                    Image(systemName: "figure.jumprope")
                                        .foregroundColor(.black)
                                    Text(section.name)
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
                    Text("No sections available")
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
    }
}

#Preview {
    TrainingSectionListView(viewModel: CardViewModel(service: CardService()), trainingProgram: TrainingProgram.samplePrograms[1])
}
