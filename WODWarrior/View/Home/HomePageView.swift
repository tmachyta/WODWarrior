//
//  HomePageView.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import SwiftUI

struct HomePageView: View {
    @Binding var selectedTab: Int
    @State private var isShowingDatePicker = false
    @State private var selectedDate = Date()
    
    // Оголосити dateFormatter
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Never Give Up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("Just Do It")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Button(action: {
                    selectedTab = 1
                }) {
                    Text("LET'S GO")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray]), startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
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
        }
    }
}

#Preview {
    HomePageView(selectedTab: .constant(0))
}
