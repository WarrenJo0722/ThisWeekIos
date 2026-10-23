//
//  MatchViewModel.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/23/26.
//

import SwiftUI

enum MatchPhase {
    case apply
    case waiting
    case matched
}

@Observable
class MatchViewModel {
    var isApplied = false
    var isMatched = false
    
    var phase: MatchPhase {
        if isMatched {
            return .matched
        }
        if isApplied {
            return .waiting
        }
        return .apply
    }
    
    func apply() {
        isApplied = true
    }
    
    func match() {
        isMatched = true
    }
}
