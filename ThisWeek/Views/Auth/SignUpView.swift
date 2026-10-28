//
//  RegisterView.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/23/26.
//

import SwiftUI
import PhotosUI

struct SignUpView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(UserViewModel.self) private var userViewModel
    
    var onSignUp: () -> Void = {}
    
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
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var imageData: Data?
    @State private var isLoading = false
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images
                    ) {
                        Group {
                            if let imageData, let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                            } else {
                                Image(systemName: "camera.fill")
                                    .font(.largeTitle)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .frame(width: 120, height: 120)
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                    }
                    
                    Spacer()
                }
            }
            .listRowBackground(Color.clear)
            
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
        .navigationTitle("회원 가입")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(text: "가입하기") {
                let user = User(nick: nick, email: email, age: Int(age) ?? 0, gender: gender, job: job, mbti: mbti, greeting: greeting)
                
                isLoading = true
                
                userViewModel.signUp(user: user, password: password, imageData: imageData) {
                    isLoading = false
                    onSignUp()
                } onFailure: { message in
                    isLoading = false
                    errorMessage = message
                    showError = true
                }
            }
            .padding()
        }
        .alert("가입 실패", isPresented: $showError) {
            Button("확인", role: .cancel) {}
        } message: {
            Text(errorMessage)
        }
        .onChange(of: selectedItem) {
            Task {
                if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                    imageData = UIImage(data: data)?.jpegData(compressionQuality: 0.7)
                }
            }
        }
        .overlay {
            if isLoading {
                ProgressView("가입 중...")
                    .padding()
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
            }
        }

    }
}

#Preview {
    NavigationStack {
        SignUpView()
            .environment(UserViewModel())
    }
}
