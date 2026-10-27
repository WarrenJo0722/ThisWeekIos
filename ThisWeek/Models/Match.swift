//
//  Match.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/27/26.
//

import FirebaseFirestore

struct Match: Codable, Identifiable {
    @DocumentID var id: String?
    var week: Int
    var user1id: String
    var user2id: String
    var place: Place
    var weekday: Weekday
}
