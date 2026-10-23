//
//  MatchTabView.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/23/26.
//

import SwiftUI

struct MatchTabView: View {
    @Environment(MatchViewModel.self)
    private var matchViewModel
    
    var body: some View {
        switch matchViewModel.phase {
        case .apply:
            ApplyView() {
                matchViewModel.apply()
            }
        case .waiting:
            Text("대기 화면")
        case .matched:
            ProfileView()
        }
    }
}

#Preview {
    MatchTabView()
}
