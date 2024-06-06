//
//  SwipeActionIndicatorView.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import SwiftUI

struct SwipeActionIndicatorView: View {
    @Binding var xOffset: CGFloat
    
    var body: some View {
        HStack {
            Text("DO TODAY")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundStyle(.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.white, lineWidth: 2)
                        .frame(width: 150, height: 58)
                }
                .rotationEffect(.degrees(-45))
                .opacity(Double(xOffset / SizeConstants.screenCutoff))
            
            Spacer()
            
            Text("NOT TODAY")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundStyle(.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.white, lineWidth: 2)
                        .frame(width: 175, height: 58)
                }
                .rotationEffect(.degrees(45))
                .opacity(Double(xOffset / SizeConstants.screenCutoff) * -1)
        }
        .padding(40)
    }
}

#Preview {
    SwipeActionIndicatorView(xOffset: .constant(20))
}
