//
//  MatchViewModel.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/23/26.
//

import SwiftUI
import FirebaseFirestore

enum MatchPhase {
    case apply
    case waiting
    case matched
}

@Observable
class MatchViewModel {
    var isApplied = false
    var isMatched = false
    
    var week = 1
    
    var phase: MatchPhase {
        if isMatched {
            return .matched
        }
        if isApplied {
            return .waiting
        }
        return .apply
    }
    
    func apply(
        userId: String,
        weekday: Weekday,
        place: Place,
        onSuccess: @escaping () -> Void = {},
        onFailure: @escaping (String) -> Void = { _ in }
    ) {
        let app = Application(
            userId: userId,
            week: week,
            weekday: weekday,
            place: place
        )
        
        do {
            try Firestore.firestore()
                .collection("applications")
                .addDocument(from: app) { error in
                    if let error {
                        onFailure(error.localizedDescription)
                    } else {
                        onSuccess()
                    }
                }
        } catch {
            onFailure(error.localizedDescription)
        }
        
        
        isApplied = true
    }
    
    func match() {
        isMatched = true
    }
}
