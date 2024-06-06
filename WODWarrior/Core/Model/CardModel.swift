//
//  CardModel.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import Foundation

struct CardModel {
    let trainingProgram: TrainingProgram
}

extension CardModel: Identifiable, Hashable {
    var id: String { return trainingProgram.name }
}
