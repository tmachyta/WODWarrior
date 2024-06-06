//
//  TrainingSection.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import Foundation
import SwiftData

@Model
class TrainingSection {
    var name: String
    var exercises: [Exercise]?
    
    @Relationship(inverse: \TrainingProgram.sections)
    var trainingProgram: TrainingProgram?
    
    init(name: String = "", exercises: [Exercise]? = nil) {
        self.name = name
    }
}

