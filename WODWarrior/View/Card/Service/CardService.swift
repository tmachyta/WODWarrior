//
//  CardService.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import Foundation
import SwiftUI
import SwiftData

struct CardService {
    @Query private var programs: [TrainingProgram]
    
    func fetchCardModels() async throws -> [CardModel] {
           return programs.map { CardModel(trainingProgram: $0) }
    }
}
