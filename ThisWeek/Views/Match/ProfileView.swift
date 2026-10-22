//
//  ProfileView.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/22/26.
//

import SwiftUI

struct ProfileView: View {
    @State private var isProfileBlurred = true
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("이번 주 인연")
                .font(.custom("NotoSerifKR-Bold", size: 28, relativeTo: .title))
            
            // 이미지 영역
            ProfileCard(isBlurred: isProfileBlurred)
            
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
}
