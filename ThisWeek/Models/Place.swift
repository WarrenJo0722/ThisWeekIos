//
//  Weekday.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/23/26.
//

import Foundation

enum Place: String, CaseIterable {
    case gangnam = "GANGNAM"
    case hongdae = "HONGDAE"
    case nowon = "NOWON"
    case yeongdeungpo = "YEONGDEUNGPO"
    
    var label: String {
        switch self {
        case .gangnam: "강남"
        case .hongdae: "홍대"
        case .nowon: "노원"
        case .yeongdeungpo: "영등포"
        }
    }
}
