//
//  User.swift
//  Hive
//
//  Created by Danil Masnaviev on 18/01/24.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
