//
//  User.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/26/26.
//

import Foundation
import FirebaseFirestore

struct User: Codable, Identifiable {
    @DocumentID
    var id: String?
    var nick: String
    var email: String
    var age: Int
    var gender: Gender
    var job: String
    var mbti: String
    var greeting: String
}

enum Gender: String, CaseIterable, Codable {
    case male = "MALE"
    case female = "FEMALE"
    
    var label: String {
        switch self {
        case .male: "남성"
        case .female: "여성"
        }
    }
}
