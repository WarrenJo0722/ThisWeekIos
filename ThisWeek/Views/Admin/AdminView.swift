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
    @Environment(UserViewModel.self)
    var userViewModel
    
    @State private var showRegister = false
    
    var body: some View {
        List {
            Section("현재 회원") {
                Text(userViewModel.currentUser?.nick ?? "선택 안함")
                    .foregroundStyle(userViewModel.currentUser == nil ? .secondary : .primary)
            }
            
            Button {
                showRegister = true
            } label: {
                HStack {
                    Text("회원 생성")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.footnote.weight(.semibold))
                        .foregroundStyle(.tertiary)
                }
            }
            
            NavigationLink("회원 목록") {
                UserListView()
            }
            
            NavigationLink("매칭하기") {
                Button("매칭하기") {
                    matchViewModel.match()
                }
            }
        }
        .navigationTitle("관리자")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showRegister) {
            NavigationStack {
                RegisterView()
            }
        }
    }
}

#Preview {
    NavigationStack {
        AdminView()
            .environment(MatchViewModel())
            .environment(UserViewModel())
    }
}
