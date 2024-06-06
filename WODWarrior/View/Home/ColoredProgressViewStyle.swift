//
//  ColoredProgressViewStyle.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import Foundation
import SwiftUI

struct ColoredProgressViewStyle: ProgressViewStyle {
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .colorScheme(.dark)
            .accentColor(color)
    }
}
