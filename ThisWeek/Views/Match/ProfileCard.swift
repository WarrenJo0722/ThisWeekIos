//
//  ProfileCard.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/22/26.
//

import SwiftUI

struct ProfileCard: View {
    let isBlurred: Bool
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Color.clear
                .frame(height: 500)
                .overlay {
                    Image(.zena)
                        .resizable()
                        .scaledToFill()
                        .blur(radius: isBlurred ? 16 : 0)
                }
                .overlay {
                    LinearGradient(
                        colors: [.clear, .black.opacity(0.5)],
                        startPoint: .center,
                        endPoint: .bottom
                    )
                }
                .clipped()
            
            VStack(alignment: .leading) {
                HStack(alignment: .bottom) {
                    profileText("제나", font: .title2)
                    profileText("19")
                }
                .padding(.bottom, 2)
                profileText("직업: 가수")
                profileText("MBTI: ENFP")
                    .padding(.bottom, 2)
                profileText("까엉!")
            }
            .padding()
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 2)
    }
    
    /// 뷰 컴포넌트 화 하는 방법
    /// 1. 연산 프로퍼티로 빼는 방법
    /// 특징 : 매개변수 못 받음
//    var profileText: some View {
//        Text("닉네임 : 제나")
//            .foregroundStyle(.white)
//    }
    
    /// 2. 함수로 빼는 방법
    /// 특징: 매개변수 받을 수 있다.
    func profileText(_ text: String, font: Font = .body) -> some View {
        Text(text)
            .foregroundStyle(.white)
            .font(font)
            .fontWeight(.bold)
            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
    }
}

#Preview {
    ProfileCard(isBlurred: true)
        .padding()
}

/// 3. 구조체로 빼는 방법
/// 매개변수 받을 수 있고, 상태 등도 정의할 수 있다.
struct ProfileText: View {
    var body: some View {
        Text("직업 : 가수")
            .foregroundStyle(.white)
    }
}
