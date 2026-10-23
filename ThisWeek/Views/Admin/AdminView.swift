//
//  AdminView.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/23/26.
//

import SwiftUI

struct AdminView: View {
    @Environment(MatchViewModel.self)
    var matchViewModel
    
    var body: some View {
        List {
            NavigationLink("유저 생성") {
                RegisterView()
            }
            NavigationLink("매칭하기") {
                Button("매칭하기") {
                    matchViewModel.match()
                }
            }
        }
        .navigationTitle("관리자")
    }
}

#Preview {
    AdminView()
}
