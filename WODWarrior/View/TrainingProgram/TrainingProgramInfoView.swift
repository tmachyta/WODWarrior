//
//  TrainingProgramInfoView.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import SwiftUI

struct TrainingProgramInfoView: View {
    @Binding var showProfileModel: Bool
    @State var trainingProgram = TrainingProgram()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(trainingProgram.name)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.heavy)
                
                Spacer()
                
                Button {
                    showProfileModel.toggle()
                } label: {
                    Image(systemName: "arrow.up.circle")
                        .fontWeight(.bold)
                        .imageScale(.large)
                }
            }
        }
        .foregroundStyle(.white)
        .padding()
        .background(
            LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
        )
        
    }
}

#Preview {
    let preview = Preview(TrainingProgram.self)
    return TrainingProgramInfoView(showProfileModel: .constant(false), trainingProgram: TrainingProgram.samplePrograms[1])
            .modelContainer(preview.container)
}
