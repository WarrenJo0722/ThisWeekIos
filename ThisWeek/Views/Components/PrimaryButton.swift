//
//  PrimaryButton.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/22/26.
//

import SwiftUI

struct PrimaryButton: View {
    let text: String
    var action: () -> Void = {}
    
    var body: some View {
        Button {
            // 액션
            action()
        } label: {
            // 버튼 뷰 커스텀 영역
            Text(text)
                .frame(maxWidth: .infinity/*, maxHeight: 50*/)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .buttonBorderShape(.roundedRectangle(radius: 12))
    }
}

#Preview {
    PrimaryButton(text: "만남완료")
        .padding()
}
