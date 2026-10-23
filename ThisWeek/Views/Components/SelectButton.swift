//
//  SelectButton.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/23/26.
//

import SwiftUI

struct SelectButton: View {
    let text: String
    let isSelected: Bool
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.headline)
                .foregroundStyle(isSelected ? .white : .black)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(isSelected ? .black : .white, in: RoundedRectangle(cornerRadius: 12))
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isSelected ? .black : Color(.systemGray4), lineWidth: 1)
                }
        }
    }
}

#Preview {
    HStack {
        SelectButton(text: "토요일", isSelected: true)
        SelectButton(text: "일요일", isSelected: false)
    }
    .padding()
}
