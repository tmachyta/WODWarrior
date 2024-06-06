//
//  TrainingProgram.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import Foundation
import SwiftData

@Model
class TrainingProgram: ObservableObject {
    var name: String
    var about: String
    @Attribute(.externalStorage)
    var images: [Data]?
    var date: Date?
    var sections: [TrainingSection]?
    
    init(name: String = "", about: String = "", images: [Data] = [], date: Date? = nil, sections: [TrainingSection]? = nil) {
        self.name = name
        self.about = about
        self.images = images
        self.date = date
    }
}
