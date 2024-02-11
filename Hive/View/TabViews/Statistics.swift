//
//  Statistics.swift
//  Hive
//
//  Created by Danil Masnaviev on 19/01/24.
//

import FirebaseFirestoreSwift
import FirebaseAuth

import SwiftUI
import Charts

struct Statistics: View {
    @FirestoreQuery var items: [Activity]
    
    private let userID: String
    
    init(userID: String) {
        self.userID = userID
        self._items = FirestoreQuery(collectionPath: "users/\(userID)/activities")
    }
    
    var body: some View {
        let chartItems: [ChartItem] = items.map { activity in
            return ChartItem(title: activity.title, totalTime: activity.totalTime)
        }
        
        NavigationView {
            VStack {
                Text("Данные за все время")
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                Chart(chartItems, id: \.title) { dataItem in
                    SectorMark(
                        angle: .value("Hours", dataItem.totalTime),
                        innerRadius: .ratio(0.6),
                        angularInset: 2.0
                    )
                    .foregroundStyle(by: .value("Type", dataItem.title))
                    .cornerRadius(10.0)
                    .annotation(position: .overlay) {
                        Text("\(dataItem.totalTime.toHours()) ч.")
                            .font(.headline)
                            .foregroundStyle(.white)
                    }
                }
                .chartBackground { proxy in
                    Text("HIVE")
                        .font(.headline)
                }
                .padding()
                .padding(.top, -20)
            }
            .navigationTitle("Статистика")
        }
    }
}

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)!
    }
}

#Preview {
    Statistics(userID: "lmmLGYusVpf6M9JJZHu0EHLLohP2")
}
