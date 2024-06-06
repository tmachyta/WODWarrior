//
//  TrainingProgramProfileView.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import SwiftUI

struct TrainingProgramProfileView: View {
    @Environment(\.dismiss) var dismiss
    @State private var currentImageIndex = 0
    
    let trainingProgram: TrainingProgram
    
    var body: some View {
        VStack {
            HStack {
                Text(trainingProgram.name)
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.down.circle.fill")
                        .imageScale(.large)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                }
            }
            .padding(.horizontal)
            
            ScrollView {
                VStack {
                    ZStack(alignment: .top) {
                        if let images = trainingProgram.images {
                                if let imageData = images[safe: currentImageIndex], let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: SizeConstants.cardWidth, height: SizeConstants.cardHeight)
                                        .overlay {
                                            ImageScrollingOverlay(currentImageIndex: $currentImageIndex, imageCount: images.count)
                                        }
                                }
                            }
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName:"questionmark.circle")
                            Text("About program:")
                                .fontWeight(.semibold)
                        }
                        HStack {
                            Image(systemName:"figure.strengthtraining.traditional")
                            Text(trainingProgram.about)
                        }
                        
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .font(.subheadline)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
    }
}

#Preview {
    let preview = Preview(TrainingProgram.self)
    return TrainingProgramProfileView(trainingProgram: TrainingProgram.samplePrograms[0])
        .modelContainer(preview.container)
}
