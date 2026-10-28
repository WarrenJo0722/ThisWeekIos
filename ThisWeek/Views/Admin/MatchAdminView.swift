//
//  MatchAdminView.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/27/26.
//

import SwiftUI

struct MatchAdminView: View {
    @Environment(MatchViewModel.self) private var matchViewModel
    @Environment(UserViewModel.self) private var userViewModel
    
    @State private var maleApp: Application?
    @State private var femaleApp: Application?
    
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    var body: some View {
        List {
            ForEach(Gender.allCases, id: \.self) { gender in
                Section(gender.label) {
                    ForEach(getApps(gender: gender)) { app in
                        if let user = userViewModel.findUser(id: app.userId) {
                            Button {
                                select(app: app, gender: gender)
                            } label: {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(user.nick)
                                            .foregroundStyle(.primary)
                                        Text("\(app.place.label) · \(app.weekday.label) · \(user.age) · \(user.mbti)")
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    if !app.matchId.isEmpty {
                                        Text("매칭 완료")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    } else if isSelected(app: app, gender: gender) {
                                        Image(systemName: "checkmark")
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.tint)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("매칭하기")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(text: "매칭하기") {
                match()
            }
            .padding()
        }
        .alert(alertMessage, isPresented: $showAlert) {
            Button("확인", role: .cancel) {}
        }
    }
    
    private func getApps(gender: Gender) -> [Application] {
        return matchViewModel.apps.filter { app in
            return userViewModel.findUser(id: app.userId)?.gender == gender
        }
    }
    
    private func isSelected(app: Application, gender: Gender) -> Bool {
        let selected = gender == .male ? maleApp : femaleApp
        return selected?.id == app.id
    }
    
    private func select(app: Application, gender: Gender) {
        if gender == .male {
            maleApp = app
        } else {
            femaleApp = app
        }
    }
    
    private func match() {
        guard let maleApp, let femaleApp else {
            return
        }
        matchViewModel.match(male: maleApp, female: femaleApp) {
            self.maleApp = nil
            self.femaleApp = nil
            alertMessage = "매칭이 완료되었습니다."
            showAlert = true
        } onFailure: { message in
            alertMessage = message
            showAlert = true
        }
    }
}

#Preview {
    NavigationStack {
        MatchAdminView()
            .environment(MatchViewModel())
            .environment(UserViewModel())
    }
}
