//
//  ProfileView.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/22/26.
//

import SwiftUI

struct ProfileView: View {
    @Environment(MatchViewModel.self) private var matchViewModel
    @Environment(UserViewModel.self) private var userViewModel
    
    @State private var isProfileBlurred = true
    
    private var partner: User? {
        guard let userId = userViewModel.currentUserId, let myApp = matchViewModel.findApp(userId: userId), let partnerApp = matchViewModel.findPartnerApp(myApp: myApp) else {
            return nil
        }
        return userViewModel.findUser(id: partnerApp.userId)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("이번 주 인연")
                .font(.custom("NotoSerifKR-Bold", size: 28, relativeTo: .title))
            
            
            // 내 신청서 -> 매치 객체 -> userId 1, 2 -> 내꺼 아닌거 아이디로 상대 유저 객체
            // 꺼내오기
            // 결론: 상대방 유저 객체
            
            // 이미지 영역
            if let partner {
                ProfileCard(
                    user: partner,
                    isBlurred: isProfileBlurred
                )
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, minHeight: 500)
            }
            
            Spacer()
            
            PrimaryButton(text: "대화하기")
                .padding(.bottom, 4)
            PrimaryButton(text: "만남완료") {
                withAnimation {
                    isProfileBlurred = false
                }
            }
        }
        .padding()
    }
}

#Preview {
    ProfileView()
        .environment(MatchViewModel())
        .environment(UserViewModel())
}
