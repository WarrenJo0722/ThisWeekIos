//
//  Weekday.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/23/26.
//

import Foundation

enum Place: String, CaseIterable, Codable {
    case gangnam = "GANG"
    case hongdae = "HONG"
    case nowon = "NOWON"
    case yeongdeungpo = "YEONG"
    
    var label: String {
        switch self {
        case .gangnam: "강남"
        case .hongdae: "홍대"
        case .nowon: "노원"
        case .yeongdeungpo: "영등포"
        }
    }
}
