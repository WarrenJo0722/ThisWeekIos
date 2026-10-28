//
//  MatchTabView.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/23/26.
//

import SwiftUI

struct MatchTabView: View {
    @Environment(MatchViewModel.self) private var matchViewModel
    @Environment(UserViewModel.self) private var userViewModel
    
    var onChat: () -> Void = {}
    
    var body: some View {
        if let userId = userViewModel.currentUserId {
            switch matchViewModel.phase(userId: userId) {
            case .apply:
                ApplyView()
            case .waiting:
                Text("대기 화면")
            case .matched:
                ProfileView(onChat: onChat)
            }
        } else {
            ContentUnavailableView(
                "회원을 먼저 선택해 주세요.",
                systemImage: "person.crop.circle.badge.questionmark",
                description: Text("관리자 → 회원 목록에서 고를 수 있어요.")
            )
        }
    }
}

#Preview {
    MatchTabView()
        .environment(MatchViewModel())
        .environment(UserViewModel())
}
