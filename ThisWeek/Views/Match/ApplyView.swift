//
//  ApplyView.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/23/26.
//

import SwiftUI

struct ApplyView: View {
    var onApply: () -> Void = {}
    
    @State private var selectedWeekday: Weekday = .saturday
    @State private var selectedPlace: Place = .gangnam
    @State private var isAgreed: Bool = false
    
    var body: some View {
        VStack {
            // 본문 영역
            
            ScrollView {
                VStack(alignment: .leading) {
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
                        이번 주,
                        소개팅
                        나가보실래요?
                        """)
                    .font(.serifBold(34))
                    .lineSpacing(2)
                    .padding(.bottom)
                    Text("""
                        상대가 누구인지는 아직 몰라요.
                        주선자가 직접 한 분을 골라 드려요.
                        """)
                    .font(.callout)
                    .foregroundStyle(.gray)
                    .lineSpacing(6)
                    .padding(.bottom, 32)
                    
                    HStack() {
                        VStack(alignment: .leading) {
                            Rectangle()
                                .frame(maxWidth: .infinity, maxHeight: 4)
                                .foregroundStyle(.brown)
                            Text("신청")
                                .foregroundStyle(.brown)
                                .fontWeight(.bold)
                        }
                        VStack(alignment: .leading) {
                            Rectangle()
                                .frame(maxWidth: .infinity, maxHeight: 4)
                                .foregroundStyle(.gray)
                            Text("매칭 대기")
                                .foregroundStyle(.gray)
                                .fontWeight(.bold)
                        }
                        VStack(alignment: .leading) {
                            Rectangle()
                                .frame(maxWidth: .infinity, maxHeight: 4)
                                .foregroundStyle(.gray)
                            Text("만남")
                                .foregroundStyle(.gray)
                                .fontWeight(.bold)
                        }
                    }
                    .padding(.bottom, 32)
                    
                    Text("언제 만날까요?")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    HStack {
                        ForEach(Weekday.allCases, id: \.self) { weekday in
                            SelectButton(
                                text: weekday.label,
                                isSelected: selectedWeekday == weekday
                            ) {
                                selectedWeekday = weekday
                            }
                        }
                    }
                    .padding(.bottom, 32)
                    
                    Text("어디서 만날까요?")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    LazyVGrid(
                        columns: [GridItem(.flexible()), GridItem(.flexible())],
                        spacing: 12
                    ) {
                        ForEach(Place.allCases, id: \.self) { place in
                            SelectButton(
                                text: place.label,
                                isSelected: selectedPlace == place
                            ) {
                                selectedPlace = place
                            }
                        }
                    }
                    .padding(.bottom, 32)
                    
                    Button {
                        isAgreed.toggle()
                    } label: {
                        HStack(alignment: .top) {
                            Image(systemName: isAgreed ? "checkmark.circle.fill" : "circle")
                                .font(.title3)
                                .foregroundStyle(isAgreed ? .black : Color(.systemGray3))
                            VStack(alignment: .leading) {
                                Text("소개팅 상대가 매칭되면 꼭 만나기로 약속해요.")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Text("만남으로 이어지지 않을 경우 다음 이용에 제한이 있을 수 있어요.")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                }
                .padding(24)
            }
            .scrollIndicators(.hidden)
            
            // 버튼 영역
            PrimaryButton(text: "이번 주 신청하기", action: onApply)
            .disabled(!isAgreed)
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
        }
    }
}

#Preview {
    ApplyView()
}
