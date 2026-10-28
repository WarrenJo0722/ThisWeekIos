//
//  AppRouter.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/23/26.
//

import SwiftUI

enum Route: Hashable {
    case main
    case admin
    case signUp
    case login
}

struct AppRouter: View {
    // path: [.intro, .main, signup]
    @State private var path: [Route] = []
    @State private var matchViewModel = MatchViewModel()
    @State private var userViewModel = UserViewModel()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .topTrailing) {
                // 인트로 화면
                IntroView() {
                    // path: [.intro]
                    if userViewModel.currentUserId == nil {
                        // path: [.intro, .login]
                        path.append(.login)
                        
                        // 로그인 화면에서 회원가입 화면으로 가면
                        // path: [.intro, .login, .signUp]
                        
                        // 로그인 또는 회원가입 화면에서 메인으로 갔을때
                        // path: [.intro, .login, .signUp, .main]
                    } else {
                        // path: [.intro, .main]
                        path.append(.main)
                    }
                }
                
                // 관리자 투명 화면
                Button {
                    path.append(.admin)
                } label: {
                    Label("관리자", systemImage: "person")
                }
                .tint(.blue)
                .padding()
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .main:
                    MainView() {
                        path.removeAll()
                    }
                case .admin:
                    AdminView()
                case .login:
                    LoginView(
                        // path: [.main]
                        onLogin: { path = [.main] },
                        onSignUp: { path.append(.signUp) }
                    )
                case .signUp:
                    SignUpView() {
                        // path: [.main]
                        path = [.main]
                    }
                }
            }
        }
        .environment(matchViewModel)
        .environment(userViewModel)
        .onAppear {
            userViewModel.checkLogin()
            userViewModel.listenUsers()
            matchViewModel.listenApps()
        }
    }
}

#Preview {
    AppRouter()
}
