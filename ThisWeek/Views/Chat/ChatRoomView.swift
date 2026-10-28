//
//  ChatRoomView.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/28/26.
//

import SwiftUI

struct ChatRoomView: View {
    @State private var input = ""
    
    // [(1, "b"), (1, "b")]
    private let samples: [(text: String, isMine: Bool)] = [
        ("안녕하세요!", false),
        ("우와 반값습니다!!", true),
        ("토요일 순살치킨 괜찮으세요?", false),
        ("너무 좋습니다! 시간은 언제가 괜찮으세요?", true)
    ]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(samples.indices, id: \.self) { index in
                    let message = samples[index]
                    HStack {
                        if message.isMine {
                            Spacer()
                        }
                        Text(message.text)
                        if !message.isMine {
                            Spacer()
                        }
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                TextField("메시지를 입력하세요", text: $input)
                Button {
                    
                } label: {
                    Image(systemName: "paperplane.fill")
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(.bar)
        }
        .navigationTitle("상대 닉네임")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ChatRoomView()
    }
}
