//
//  Session.swift
//  Hive
//
//  Created by Danil Masnaviev on 19/01/24.
//

import Foundation

struct Session: Codable, Identifiable {
    let id: String
    var activityID: String
    var activityName: String
    var dateStarted: String
    var startTime: String
    var endTime: String
    var duration: TimeInterval

    init(id: String, activityID: String, activityName: String, dateStarted: String, startTime: String, endTime: String, duration: TimeInterval) {
        self.id = id
        self.activityID = activityID
        self.activityName = activityName
        self.dateStarted = dateStarted
        self.startTime = startTime
        self.endTime = endTime
        self.duration = duration
    }
}
