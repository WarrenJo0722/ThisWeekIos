//
//  LoginView.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/28/26.
//

import SwiftUI

struct LoginView: View {
    @Environment(UserViewModel.self) private var userViewModel
    
    var onLogin: () -> Void = {}
    var onSignUp: () -> Void = {}
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var showPassword = false
    
    var body: some View {
        VStack(spacing: 16) {
            Text("로그인")
                .font(.serifBold(28))
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("이메일", text: $email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
            HStack {
                Group {
                    if showPassword {
                        TextField("비밀번호", text: $password)
                    } else {
                        SecureField("비밀번호", text: $password)
                    }
                }
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
                
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
            
            PrimaryButton(text: "로그인") {
                userViewModel.login(email: email, password: password) {
                    onLogin()
                }
            }
            
            Button("아직 회원이 아니신가요? 회원가입") {
                onSignUp()
            }
        }
        .padding()
    }
}

#Preview {
    LoginView()
        .environment(UserViewModel())
}
