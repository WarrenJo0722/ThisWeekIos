//
//  IntroView.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/22/26.
//

import SwiftUI

struct IntroView: View {
    private let features = [
        ("01", "주 1회", "매주, 딱 한 번의 인연"),
        ("02", "단 한 명", "고르지 않아요, 골라 드려요"),
        ("03", "무조건 만약", "매칭되면 꼭 만나요"),
        ("04", "블라인드", "얼굴은 만나서 공개돼요")
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("이번주소개팅")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(.black, in: Capsule())
                .padding(.bottom, 16)
            HStack {
                Rectangle()
                    .fill(Color.brown)
                    .frame(width: 36, height: 1.5)
                Text("WEEKLY · BLIND MATCH")
                    .font(.caption)
                    .fontWeight(.bold)
                    .tracking(2)
                    .foregroundStyle(Color.brown)
            } // 글자 간격
                
            Text("""
                회사명이 아니라,
                당신이라는
                사람으로 만나요.
                """)
            .font(.serifBold(34))
            .lineSpacing(2)
            .padding(.bottom)
            Text("""
                주 1회, 단 한 명, 무조건 만나는 의식
                상대는 주선자가 직접 골라 드려요.
                """)
            .font(.callout)
            .foregroundStyle(.gray)
            .lineSpacing(6)
            .padding(.bottom, 32)
            
            VStack(alignment: .leading) {
                ForEach(features, id: \.0) { num, title, desc in
                    Divider()
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, maxHeight: 1)
                    HStack(alignment: .top) {
                        Text(num)
                            .font(.serifBold(18))
                            .foregroundStyle(.brown)
                        VStack(alignment: .leading) {
                            Text(title)
                                .font(.headline)
                            Text(desc)
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        }
                    }
                    .padding(.vertical)
                }
            }
            Divider()
            
            Spacer()

            PrimaryButton(text: "시작하기")
        }
        .padding(24)
    }
}

#Preview {
    IntroView()
}
