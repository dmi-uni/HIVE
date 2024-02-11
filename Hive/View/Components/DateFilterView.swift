//
//  DateFilterView.swift
//  Hive
//
//  Created by Danil Masnaviev on 23/01/24.
//

import SwiftUI

struct DateFilterView: View {
    @State var start: Date
    @State var end: Date
    var onSubmit: (Date, Date) -> ()
    var onClose: () -> ()
    
    var body: some View {
        VStack(spacing: 15) {
            DatePicker("Начало", selection: $start, displayedComponents: [.date])
            
            DatePicker("Конец", selection: $end, displayedComponents: [.date])
            
            HStack(spacing: 15) {
                Button("Отменить") {
                    onClose()
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 5))
                .tint(.appRed)
                
                Button("Подтвердить") {
                    onSubmit(start, end)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 5))
                .tint(.appGreen)
            }
            .padding(.top, 10)
        }
        .padding(15)
        .background(.bar, in: .rect(cornerRadius: 10))
        .padding(.horizontal, 30)
    }
}
