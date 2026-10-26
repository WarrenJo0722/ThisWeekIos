//
//  UserListView.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/26/26.
//

import SwiftUI

struct UserListView: View {
    @Environment(UserViewModel.self) private var userViewModel
    
    var body: some View {
        List(userViewModel.users) { user in
            Button {
                userViewModel.selectUser(user: user)
            } label: {
                HStack {
                    VStack(alignment: .leading) {
                        Text(user.nick)
                            .foregroundStyle(.primary)
                        Text("\(user.gender.label) · \(user.age) ·  \(user.mbti)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    if userViewModel.currentUserId == user.id {
                        Image(systemName: "checkmark")
                            .fontWeight(.semibold)
                            .foregroundStyle(.tint)
                    }
                }
            }
            .swipeActions {
                Button("삭제", role: .destructive) {
                    userViewModel.deleteUser(user: user)
                }
            }
        }
        .navigationTitle("회원 목록")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        UserListView()
            .environment(UserViewModel())
    }
}
