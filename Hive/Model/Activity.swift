//
//  Activity.swift
//  Hive
//
//  Created by Danil Masnaviev on 18/01/24.
//

import Foundation
import SwiftUI

struct Activity: Codable, Identifiable {
    let id: String
    let title: String
    var dateAdded: String
    var totalTime: TimeInterval
    var goal: TimeInterval
    var goalType: String
    var goalCompleted: Int
    var color: String
}
