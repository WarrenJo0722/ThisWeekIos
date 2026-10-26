//
//  User.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/26/26.
//

import Foundation
import FirebaseFirestore

struct Application: Codable, Identifiable {
    @DocumentID
    var id: String?
    var userId: String
    var week: Int
    var weekday: Weekday
    var place: Place
    var matchId: String = ""
}
