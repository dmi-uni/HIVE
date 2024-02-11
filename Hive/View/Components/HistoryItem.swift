//
//  HistoryItem.swift
//  Hive
//
//  Created by Danil Masnaviev on 23/01/24.
//

import SwiftUI

struct HistoryItem: View {
    let activityName: String
    let duration: String
    let startTime: String
    let endTime: String
    let dateStarted: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(activityName)
                    .font(.headline)
                Text("\(duration) ч.")
                    .foregroundColor(.gray)
                    .font(.callout)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("\(startTime) - \(endTime)")
                    .font(.headline)
                Text(dateStarted)
                    .foregroundColor(.gray)
                    .font(.subheadline)
            }
        }
        .background(.clear)
    }
}

#Preview {
    HistoryItem(activityName: "Тест", duration: "2.5", startTime: "19:02", endTime: "21:55", dateStarted: "2024-01-23")
}
