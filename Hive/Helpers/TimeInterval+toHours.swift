//
//  TimeInterval+toHours.swift
//  Hive
//
//  Created by Danil Masnaviev on 23/01/24.
//

import Foundation

extension TimeInterval {
    func toHours(decimalPlaces: Int = 1) -> String {
        let hours = self / 3600.0
        return String(format: "%.\(decimalPlaces)f", hours)
    }
}
