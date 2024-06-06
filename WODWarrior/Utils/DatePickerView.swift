//
//  DatePickerView.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import Foundation
import SwiftUI

struct DatePickerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedDate: Date

    var body: some View {
            VStack {
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding()
                
                Button("Done") {
                    dismiss()
                }
                .padding()
            }
        }
    }

#Preview {
    Group {
        DatePickerView(selectedDate: .constant(Date()))
    }
}
