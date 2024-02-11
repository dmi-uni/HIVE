//
//  HiveApp.swift
//  Hive
//
//  Created by Danil Masnaviev on 18/01/24.
//

import SwiftUI
import FirebaseCore

@main
struct HiveApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            Main()
        }
    }
}
