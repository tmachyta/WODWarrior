//
//  Exercise.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Exercise {
    var name: String
    var about: String
    @Attribute(.externalStorage)
    var videoRelativePath: String?
    var video: URL? {
            get {
                guard let relativePath = videoRelativePath else { return nil }
                return VideoPicker.VideoType.documentDirectory().appendingPathComponent(relativePath)
            }
            set {
                if let newValue = newValue {
                    videoRelativePath = newValue.lastPathComponent
                } else {
                    videoRelativePath = nil
                }
            }
        }
    
    @Relationship(inverse: \TrainingSection.exercises)
    var trainingSection: TrainingSection?
    
    init(name: String = "", about: String = "", video: URL? = nil) {
        self.name = name
        self.about = about
        self.video = video
    }
}
