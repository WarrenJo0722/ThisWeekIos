//
//  MyPageView.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/28/26.
//

import SwiftUI

struct MyPageView: View {
    var onLogout: () -> Void = {}
    
    @Environment(UserViewModel.self) private var userViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            
            AsyncImage(
                url: URL(string: userViewModel.currentUser?.imageUrl ?? "")
            ) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Image(systemName: "person.fill")
                    .font(.system(size: 50))
                    .foregroundStyle(.secondary)
            }
            .frame(width: 120, height: 120)
            .background(Color(.systemGray5))
            .clipShape(Circle())
            .padding(.bottom, 8)
            
            Text(userViewModel.currentUser?.nick ?? "")
                .font(.serifBold(28))
            Text(userViewModel.currentUser?.email ?? "")
                .foregroundStyle(.secondary)
            Spacer()
            PrimaryButton(text: "로그아웃") {
                userViewModel.logout()
                onLogout()
            }
        }
        .padding(24)
    }
}

#Preview {
    MyPageView()
        .environment(UserViewModel())
}
