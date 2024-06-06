//
//  CardView.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var viewModel: CardViewModel
    @Environment(\.dismiss) var dismiss
    @State private var xOffset: CGFloat = 0
    @State private var degrees: Double = 0
    @State private var currentImageIndex = 0
    @State private var allCardsSwipedLeft = false
    @State private var isNavigationActive = false
    @State private var showProfileModel = false
    @Environment(\.presentationMode) var presentationMode
    
    let model: CardModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                if let images = trainingProgram.images,
                   let imageData = images[safe: currentImageIndex],
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: SizeConstants.cardWidth, height: SizeConstants.cardHeight)
                        .overlay {
                            ImageScrollingOverlay(currentImageIndex: $currentImageIndex, imageCount: images.count)
                        }
                } else {
                    Text("No image available")
                        .frame(width: SizeConstants.cardWidth, height: SizeConstants.cardHeight)
                }
                
                SwipeActionIndicatorView(xOffset: $xOffset)
                
            }
            
            TrainingProgramInfoView(showProfileModel: $showProfileModel, trainingProgram: trainingProgram)
                .onTapGesture {
                    showProfileModel = true
                }
        }
        .fullScreenCover(isPresented: $showProfileModel) {
            TrainingProgramProfileView(trainingProgram: trainingProgram)
        }
        .frame(width: SizeConstants.cardWidth, height: SizeConstants.cardHeight)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .offset(x: xOffset)
        .rotationEffect(.degrees(degrees))
        .gesture(
            DragGesture()
                .onChanged(onDragChanged)
                .onEnded(onDragEnded)
            
        )
        
        NavigationLink(
            destination: TrainingSectionListView(viewModel: viewModel, trainingProgram: trainingProgram)
                .onAppear {
                    isNavigationActive = false
                },
            isActive: $isNavigationActive
        ) {
            EmptyView()
        }.hidden()
    }
}
    
private extension CardView {
        var trainingProgram: TrainingProgram {
            return model.trainingProgram
        }
        
        var imageCount: Int {
            return trainingProgram.images?.count ?? 0
        }
    }

private extension CardView {
    
    func returnToCenter() {
        xOffset = 0
        degrees = 0
        currentImageIndex = 0
    }
    
    func swipeRight() {
        withAnimation {
            xOffset = 500
            degrees = 12
        }
        currentImageIndex += 1
        isNavigationActive = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            returnToCenter()
        }
    }
    
    func swipeLeft() {
        withAnimation {
            xOffset = -500
            degrees = -12
            currentImageIndex += 1
            if currentImageIndex == imageCount {
                allCardsSwipedLeft = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                withAnimation {
                    returnToCenter()
                }
            }
        }
    }
    
    func returnToBack() {
        withAnimation {
            returnToCenter()
        }
    }
}

    private extension CardView {
        func onDragChanged(_ value: _ChangedGesture<DragGesture>.Value) {
            xOffset = value.translation.width
            degrees = Double(value.translation.width / 25)
        }
        
        func onDragEnded(_ value: _ChangedGesture<DragGesture>.Value) {
            let width = value.translation.width
            
            if abs(width) <= abs(SizeConstants.screenCutoff) {
                returnToCenter()
                return
            }
            
            if width >= SizeConstants.screenCutoff {
                swipeRight()
            } else {
                swipeLeft()
            }
        }
    }

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    let preview = Preview(TrainingProgram.self)
    return CardView(
        viewModel: CardViewModel(service: CardService()),
        model: CardModel(trainingProgram: TrainingProgram.samplePrograms[0])).modelContainer(preview.container)
}
