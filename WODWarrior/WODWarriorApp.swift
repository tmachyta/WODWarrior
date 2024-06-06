//
//  WODWarriorApp.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import SwiftUI
import SwiftData

@main
struct WODWarriorApp: App {
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            MainTabBarView()
            // AdminPageView()
        }
        .modelContainer(container)
    }
    
    init() {
        let schema = Schema([TrainingProgram.self])
        let config = ModelConfiguration("MyTrainingProgram", schema: schema)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not configure the container")
        }
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
        }
}
