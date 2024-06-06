//
//  MainTabBarView.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import SwiftUI

struct MainTabBarView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomePageView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            CardStackView()
                .tabItem {
                    Image(systemName: "figure.mixed.cardio")
                    Text("Trainings")
                }
                .tag(1)
        }
        .accentColor(.white)
    }
}

#Preview {
    MainTabBarView()
}
