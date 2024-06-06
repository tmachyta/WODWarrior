//
//  TrainingProgramSamples.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import Foundation
import PhotosUI

extension TrainingProgram {
    static var samplePrograms: [TrainingProgram] = [
        TrainingProgram(name: "Lift", about: "Snatch", images: [UIImage(named: "froning2")?.jpegData(compressionQuality: 1.0)].compactMap { $0 }, date: DateComponents(calendar: .current, year: 2024, month: 6, day: 4).date, sections: [
            TrainingSection(name: "WarmUP", exercises: [
                Exercise(name: "Clean", about:"10 clean"),
                Exercise(name: "Wall Balls", about:"10 wall balls with 9kg ball")
            ])
        ]),
        TrainingProgram(name: "WOD", about: "Metcons", date: DateComponents(calendar: .current, year: 2024, month: 6, day: 4).date,
                        sections: [
            TrainingSection(name: "WarmUP", exercises: [
                Exercise(name: "Clean", about:"10 clean"),
                Exercise(name: "Wall Balls", about:"10 wall balls with 9kg ball")
            ])
        ]),
        TrainingProgram(name: "Strong", about: "Squats", date: DateComponents(calendar: .current, year: 2024, month: 6, day: 4).date,
                        sections: [
            TrainingSection(name: "WarmUP", exercises: [
                Exercise(name: "Clean", about:"10 clean"),
                Exercise(name: "Wall Balls", about:"10 wall balls with 9kg ball")
            ])
        ])
    ]
}
