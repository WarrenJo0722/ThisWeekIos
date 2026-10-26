//
//  RegisterView.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/23/26.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(UserViewModel.self) private var userViewModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var nick = ""
    @State private var gender: Gender = .male
    @State private var age = ""
    @State private var job = ""
    @State private var mbti = ""
    @State private var greeting = ""
    
    @State private var showPassword = false
    @State private var showError = false
    
    @State private var errorMessage = ""
    
    var body: some View {
        Form {
            Section("인증 정보") {
                TextField("이메일", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textContentType(.emailAddress)
                HStack {
                    if showPassword {
                        TextField("비밀번호", text: $password)
                    } else {
                        SecureField("비밀번호", text: $password)
                    }
                    
                    Button {
                        showPassword.toggle()
                    } label: {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.borderless)
                }
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .textContentType(.newPassword)
            }
            
            Section("기본 정보") {
                TextField("닉네임", text: $nick)
                    .autocorrectionDisabled()
                Picker("성별", selection: $gender) {
                    ForEach(Gender.allCases, id: \.self) { g in
                        Text(g.label).tag(g)
                    }
                }
                .pickerStyle(.segmented)
                TextField("나이", text: $age)
                    .keyboardType(.numberPad)
                TextField("직업", text: $job)
                TextField("MBTI", text: $mbti)
                    .keyboardType(.asciiCapable)
                    .textInputAutocapitalization(.characters)
                    .autocorrectionDisabled()
                TextField("한 줄 소개", text: $greeting, axis: .vertical)
                    .lineLimit(2...4)
            }
        }
        .navigationTitle("회원 생성")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("취소") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("생성") {
                    let user = User(nick: nick, email: email, age: Int(age) ?? 0, gender: gender, job: job, mbti: mbti, greeting: greeting)
                    
                    userViewModel.addUser(user: user) {
                        dismiss()
                    } onFailure: { message in
                        errorMessage = message
                    }
                }
            }
        }
        .alert("저장 실패", isPresented: $showError) {
            Button("확인", role: .cancel) {}
        } message: {
            Text(errorMessage)
        }

    }
}

#Preview {
    NavigationStack {
        RegisterView()
            .environment(UserViewModel())
    }
}
