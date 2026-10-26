//
//  ThisWeekApp.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/22/26.
//

import SwiftUI
import FirebaseCore

@main
struct ThisWeekApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            AppRouter()
        }
    }
}
