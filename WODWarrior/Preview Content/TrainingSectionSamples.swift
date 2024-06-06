//
//  TrainingSectionSamples.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import Foundation

extension TrainingSection {
    static var sampleSections: [TrainingSection] = [
        TrainingSection(name: "WarmUP",
                        exercises: [
            Exercise(name: "Clean", about: "10 clean"),
            Exercise(name: "Wall Balls", about: "10 wall balls with 9kg ball")
        ]),
        TrainingSection(name: "Snatch")
    ]
}

