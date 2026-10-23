//
//  Weekday.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/23/26.
//

import Foundation

enum Weekday: String, CaseIterable {
    case saturday = "SATURDAY"
    case sunday = "SUNDAY"
    
    var label: String {
        switch self {
        case .saturday: "토요일"
        case .sunday: "일요일"
        }
    }
}
