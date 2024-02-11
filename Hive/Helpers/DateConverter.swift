//
//  DateConverter.swift
//  Hive
//
//  Created by Danil Masnaviev on 22/01/24.
//

import Foundation


class DateConverter {
    static let shared = DateConverter()

    private let dateFormatter: ISO8601DateFormatter
    private let calendar: Calendar

    private init() {
        dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate]
        dateFormatter.timeZone = .current
        
        calendar = Calendar.current
    }

    func dateFromString(_ dateString: String) -> Date? {
        return dateFormatter.date(from: dateString)
    }

    func stringFromDate(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    func getTimeString(_ date: Date) -> String {
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        return "\(hour):\(minute)"
    }
}
