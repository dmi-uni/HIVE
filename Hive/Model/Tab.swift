//
//  Tab.swift
//  Hive
//
//  Created by Danil Masnaviev on 19/01/24.
//

import Foundation
import SwiftUI

enum Tab: String {
    case activities = "Активности"
    case history = "История"
    case charts = "Статистика"
    case settings = "Настройки"
    
    @ViewBuilder
    var tabContent: some View {
        switch self {
        case .activities:
            Image(systemName: "clock")
            Text(self.rawValue)
        case .history:
            Image(systemName: "list.clipboard")
            Text(self.rawValue)
        case .charts:
            Image(systemName: "chart.bar.xaxis")
            Text(self.rawValue)
        case .settings:
            Image(systemName: "gearshape")
            Text(self.rawValue)
        }
    }
}
